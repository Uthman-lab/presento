/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Initialize Firebase Admin SDK
admin.initializeApp();

/**
 * Cloud Function to get attendance analytics data
 * Called by the Flutter app's DashboardBloc
 */
exports.getAttendanceAnalytics = functions.https.onCall(async (data, context) => {
  try {
    // Extract parameters from the request
    const { institutionId, classId, startDate, endDate, aggregationType } = data || {};

    // Validate required parameters
    if (!institutionId || !startDate || !endDate) {
      console.warn("Missing required parameters", { institutionId, startDate, endDate });
      return { 
        success: false, 
        error: "Missing required parameters: institutionId, startDate, endDate" 
      };
    }

    console.log("Getting attendance analytics", { 
      institutionId, 
      classId, 
      startDate, 
      endDate, 
      aggregationType 
    });

    const db = admin.firestore();
    
    // Build the query
    let query = db
      .collection("attendance")
      .where("institutionId", "==", institutionId)
      .where("date", ">=", new Date(startDate))
      .where("date", "<=", new Date(endDate));

    // Add class filter if specified and not "all"
    if (classId && classId !== "all") {
      query = query.where("classId", "==", classId);
    }

    // Execute the query
    const snapshot = await query.get();
    
    console.log(`Found ${snapshot.size} attendance records`);

    // Aggregate data by date
    const dateBuckets = {};
    
    // Helper function to get date key (YYYY-MM-DD)
    const getDateKey = (timestamp) => {
      const date = (timestamp && timestamp.toDate) ? timestamp.toDate() : new Date(timestamp);
      return date.toISOString().slice(0, 10);
    };
    
    // Helper function to get short date (MM-DD)
    const getShortDate = (dateKey) => dateKey.slice(5);

    // Process each attendance record
    snapshot.forEach(doc => {
      const data = doc.data();
      const dateKey = getDateKey(data.date);
      
      // Initialize bucket if it doesn't exist
      if (!dateBuckets[dateKey]) {
        dateBuckets[dateKey] = {
          date: dateKey,
          shortDate: getShortDate(dateKey),
          presentCount: 0,
          absentCount: 0,
          lateCount: 0,
          excusedCount: 0,
          totalCount: 0,
        };
      }
      
      // Increment total count
      dateBuckets[dateKey].totalCount += 1;
      
      // Increment specific status count
      switch (data.status) {
        case "present":
          dateBuckets[dateKey].presentCount += 1;
          break;
        case "absent":
          dateBuckets[dateKey].absentCount += 1;
          break;
        case "late":
          dateBuckets[dateKey].lateCount += 1;
          break;
        case "excused":
          dateBuckets[dateKey].excusedCount += 1;
          break;
        default:
          console.warn(`Unknown attendance status: ${data.status}`);
          break;
      }
    });

    // Convert buckets to sorted array
    const analyticsData = Object.keys(dateBuckets)
      .sort()
      .map(dateKey => dateBuckets[dateKey]);

    console.log(`Returning analytics for ${analyticsData.length} days`);

    return { 
      success: true, 
      data: analyticsData 
    };

  } catch (error) {
    console.error("Error in getAttendanceAnalytics", error);
    return { 
      success: false, 
      error: error?.message || "An unexpected error occurred" 
    };
  }
});
