# Step-by-Step Guide: Publish Shishu Path to Google Play Store

This guide walks you through publishing your Flutter app (**Shishu Path**) to the Google Play Store.

---

## Prerequisites

- [ ] Google Play Developer account ($25 one-time fee) — [Create account](https://play.google.com/console/signup)
- [ ] App tested on real devices (Android 10+ recommended; your `minSdk` is 29)
- [ ] Stable internet and 1–2 hours for first-time setup

---

## Part 1: Prepare Your App for Release

### 1.1 Update app identity and version

- **App name**: Ensure it’s clear in `AndroidManifest.xml` and your launcher label.
- **Version**: You have `versionCode = 1` and `versionName = "1.0.0"` in `android/app/build.gradle`. For each new Play Store upload, **increase `versionCode`** (e.g. 1 → 2) and optionally `versionName` (e.g. `1.0.1`).

### 1.2 Create a release signing key (required for Play Store)

1. **Create a keystore** (one-time, keep it safe and backed up):

   ```bash
   keytool -genkey -v -keystore upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
   ```

   - Store the file and passwords securely. If you lose them, you cannot update the app with the same package name.

2. **Create `android/key.properties`** (do not commit to Git):

   ```properties
   storePassword=<your-keystore-password>
   keyPassword=<your-key-password>
   keyAlias=upload
   storeFile=../upload-keystore.jks
   ```

   Place `upload-keystore.jks` in `android/` (or adjust `storeFile` path). Add `key.properties` and `*.jks` to `.gitignore`.

3. **Configure signing in `android/app/build.gradle`**:

   - Add before the `android { }` block:

   ```gradle
   def keystoreProperties = new Properties()
   def keystorePropertiesFile = rootProject.file('key.properties')
   if (keystorePropertiesFile.exists()) {
       keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
   }
   ```

   - Inside `android { }`, add `signingConfigs` and use it in `buildTypes`:

   ```gradle
   signingConfigs {
       release {
           keyAlias keystoreProperties['keyAlias']
           keyPassword keystoreProperties['keyPassword']
           storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
           storePassword keystoreProperties['storePassword']
       }
   }
   buildTypes {
       release {
           signingConfig signingConfigs.release
       }
   }
   ```

### 1.3 Build the release AAB (Android App Bundle)

From the project root:

```bash
flutter clean
flutter pub get
flutter build appbundle
```

Output: `build/app/outputs/bundle/release/app-release.aab`. This is the file you upload to Play Console.

### 1.4 Optional: Test the release build locally

```bash
flutter build apk
# Install on device and test
```

---

## Part 2: Google Play Console Setup

### 2.1 Create the app in Play Console

1. Go to [Google Play Console](https://play.google.com/console).
2. Click **Create app**.
3. Fill in:
   - **App name**: Shishu Path
   - **Default language**: e.g. English (United States)
   - **App or game**: App
   - **Free or paid**: Free (or Paid if you choose)
4. Accept declarations and create the app.

### 2.2 Complete “Set up your app” (dashboard checklist)

Work through the checklist on the left. Key items:

---

## Part 3: Store Listing

### 3.1 Main store listing (Store presence → Main store listing)

- **Short description** (max 80 characters): e.g. “Learn Bangla & English alphabet, numbers, rhymes and more.”
- **Full description** (max 4000 characters): Explain features (e.g. Bangla/English learning, rhymes, audio, categories).
- **App icon**: 512 x 512 px PNG (32-bit, no transparency).
- **Feature graphic**: 1024 x 500 px (JPEG or PNG).
- **Screenshots**: At least 2 phone screenshots (min 320 px short side, max 3840 px). Use a real device or emulator.
- **Optional**: 7-inch and 10-inch tablet screenshots if you support tablets.

### 3.2 Categorization

- **App category**: e.g. Education.
- **Tags**: Optional; e.g. education, kids, Bangla, English.

---

## Part 4: Policy and Compliance

### 4.1 Privacy policy

- If you collect any user data (e.g. analytics, accounts), you **must** have a hosted privacy policy URL.
- Add it in: **Policy → App content → Privacy policy**.
- Even for a simple educational app, a short privacy policy is recommended.

### 4.2 App content questionnaire

Complete all required sections under **Policy → App content**:

- **Ads**: Declare if your app contains ads (e.g. No, if you don’t use ads).
- **App access**: If all features are available without login, say “All functionality is available without login.”
- **Content ratings**: Complete the questionnaire (e.g. kids/education) and get the rating (e.g. Everyone).
- **Target audience**: Set age groups (e.g. 3+ or 5+ for education).
- **News app**: No (unless it’s a news app).
- **COVID-19 contact tracing**: No (unless applicable).
- **Data safety**: Declare what data you collect (if any). For a simple offline app, often “No data collected.”

### 4.3 Data safety form

- In **Data safety**, state whether you collect/share data.
- For an offline kids’ learning app, typically: “No data collected” or only optional crash/analytics if you add them later.

---

## Part 5: Release Your App

### 5.1 Internal testing (optional but recommended)

1. Go to **Testing → Internal testing**.
2. Create a new release → **Upload** your `app-release.aab`.
3. Add testers by email (up to 100).
4. Save and roll out. Testers get the link to opt in and install.

### 5.2 Production release

1. Go to **Release → Production** (or **Testing → Closed testing** first if you prefer).
2. **Create new release**.
3. **Upload** the same `app-release.aab` (or a new build with higher `versionCode`).
4. **Release name**: e.g. “1.0.0 (1)”.
5. **Release notes**: Short description of what’s new (e.g. “Initial release – Bangla & English learning”).
6. **Review release** → **Start rollout to Production**.

### 5.3 Review time

- First review can take a few hours to several days.
- You’ll get an email when the app is approved, rejected, or if more info is needed.

---

## Part 6: Post-Launch

- **Version updates**: Increase `versionCode` (and `versionName`) in `android/app/build.gradle`, build a new AAB, then create a new release in the same track (e.g. Production).
- **Store listing**: You can update text and graphics anytime from the store listing page.
- **Monitor**: Use **Dashboard** and **Statistics** for crashes, installs, and ratings.

---

## Quick Checklist Before First Upload

| Task | Done |
|------|------|
| Google Play Developer account created | |
| Release keystore created and backed up | |
| `key.properties` created and in `.gitignore` | |
| Release signing configured in `build.gradle` | |
| `flutter build appbundle` succeeds | |
| App tested on device (release build) | |
| Store listing: icon, feature graphic, screenshots, short & full description | |
| Privacy policy URL (if needed) | |
| Content rating completed | |
| Target audience and Data safety completed | |
| AAB uploaded to Internal testing or Production | |

---

## Your App Details (for reference)

- **Package name**: `com.codertent.shishupath`
- **Current version**: 1.0.0 (versionCode 1)
- **Min SDK**: 29 (Android 10+)

For official docs, see [Publish your app - Play Console Help](https://support.google.com/googleplay/android-developer/answer/9859152) and [Flutter deployment - Android](https://docs.flutter.dev/deployment/android).
