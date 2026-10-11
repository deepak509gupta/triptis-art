# Tripti's Art — GitHub Pages + owner dashboard

This package includes sample artwork images so the public gallery looks populated while you test it. Use `images/floral-frame.jpg` as the first demo artwork; replace it with Tripti's real artwork photos whenever ready.

## Part A — Create a brand-new GitHub repository

1. Open https://github.com/ and sign in (create a GitHub account first if needed).
2. Click the **+** button in the top-right, then choose **New repository**. Direct link: https://github.com/new
3. Repository name: `triptis-art` (or another name you prefer).
4. Select **Public**. GitHub Pages on the free plan works with a public repository.
5. For the simplest setup, leave **Add a README**, `.gitignore`, and license unchecked; then click **Create repository**.
6. Keep this repository page open for the next step.

## Part B — Upload the website and demo artwork

1. Download and extract `triptis-art-dashboard-v2.zip` on your computer.
2. Open the extracted `triptis-art` folder.
3. In your new GitHub repository, click **Add file → Upload files**.
4. Upload the *contents* of the extracted `triptis-art` folder, not the outer folder itself. At repository root you must see:
   - `index.html`
   - `dashboard.html`
   - `README.md`
   - `supabase-setup.sql`
   - `images/` (with the `.jpg` sample artwork files inside)
5. If uploading through the browser, drag the files and the `images` folder into the upload area. Confirm that `images/` stays a folder and `index.html` is at the repository root.
6. Enter a commit message such as `Add Tripti's Art website` and click **Commit changes**.

**Demo photo included:** `images/floral-frame.jpg` is already part of the sample gallery assets. The homepage/gallery has starter art cards, so you can verify the design before Supabase is configured. The actual daily-upload dashboard requires the Supabase setup below.

## Part C — Turn on free GitHub Pages hosting

1. In the repository, open **Settings**.
2. In the left menu, click **Pages** (under **Code and automation**).
3. Under **Build and deployment**, choose **Deploy from a branch**.
4. Under **Branch**, select `main`; for the folder choose `/(root)`; click **Save**.
5. Wait a few minutes and refresh the Pages settings page. GitHub will show the published site URL.
6. For a repository named `triptis-art`, the URL format is:
   `https://YOUR-GITHUB-USERNAME.github.io/triptis-art/`
   Replace `YOUR-GITHUB-USERNAME` with your actual GitHub username. Do not use another person's username or the old `deepak509gupta.github.io` URL unless that is actually your repository/account setup.
7. The owner dashboard URL is the same base URL plus `dashboard.html`:
   `https://YOUR-GITHUB-USERNAME.github.io/triptis-art/dashboard.html`
8. Open the public URL and confirm the sample images appear. If you see a 404, confirm `index.html` is at repository root, Pages uses `main` and `/(root)`, and give deployment a few more minutes.

## Part D — Enable the phone upload dashboard (requires one-time Supabase setup)

GitHub Pages hosts static files only. Supabase provides the sign-in, database and image storage needed to publish photos from a phone.

1. Create a free project at https://supabase.com/. Save the database password privately.
2. In Supabase, open **Project Settings → API** (or **Connect**) and copy the **Project URL** and the **anon/public key** (sometimes labelled publishable key). Never use a `service_role` or secret key in browser files.
3. In GitHub, open `dashboard.html`, click the pencil/edit icon, and replace `PASTE_SUPABASE_PROJECT_URL_HERE` and `PASTE_SUPABASE_ANON_KEY_HERE` with your own values. Commit the change.
4. Open `supabase-setup.sql` in the repository, copy its complete contents, then in Supabase open **SQL Editor**, paste the SQL, and run it.
5. In Supabase **Storage**, create a public bucket named exactly `artworks`. Allow image MIME types and set a reasonable upload size limit (for example, 8 MB). The provided policies are intended to let visitors read images while signed-in users upload/delete.
6. In Supabase **Authentication → URL Configuration**, set **Site URL** to the exact GitHub Pages base URL from Part C. Add that same URL to the allowed Redirect URLs.
7. In `dashboard.html`, click **Edit** and replace the two placeholder values; commit the change.
8. In `index.html`, find `const SUPABASE_URL = ''; const SUPABASE_ANON_KEY = '';` and fill in the same Project URL and anon/public key; commit the change. This enables the public gallery to fetch new uploaded artworks.
9. Open the dashboard URL and create the owner's account using Tripti's email and a strong password. Sign in and test uploading a photo.
10. After the owner account is created and confirmed, disable public sign-ups in Supabase Authentication settings if that option is available for your project. Only the owner should be allowed to manage artwork. Do not share the dashboard as a public-facing customer page.

## Part E — Add the first demo photo and publish new work

1. Open `https://YOUR-GITHUB-USERNAME.github.io/triptis-art/dashboard.html`.
2. Sign in with the owner account.
3. Add a title such as `Demo Floral Frame`, choose a category, and select `images/floral-frame.jpg` from the extracted project folder on a computer (or use a photo saved to Tripti's phone). The dashboard file picker uploads a local file; it does not select a file from the website repository directly.
4. Click **Upload & publish**. The new entry should appear in the dashboard and, after refresh, the public gallery.
5. For future daily uploads, Tripti can open the dashboard on her phone, choose a photo from her gallery, enter its title/category/description, and tap **Upload & publish**.

## Customer enquiries and pricing

- WhatsApp contact is configured as `+91 70000 74436`.
- Prices are intentionally not displayed; customers can enquire about customization through WhatsApp.
- Instagram is not connected because no profile link was supplied.

## Security and troubleshooting

- Never commit a Supabase service-role/secret key. The browser should only use the anon/public key with row-level security enabled.
- The Supabase dashboard must have the provided SQL policies applied and the `artworks` storage bucket configured.
- If new uploads appear in the dashboard but not the public gallery, verify the Supabase values in **both** `dashboard.html` and `index.html`, then refresh the site.
- If images do not load, check the `artworks` bucket is public and the storage policies were applied successfully.
- If you change HTML after deployment, commit the changes to `main`; GitHub Pages will redeploy automatically.
