# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_03_11_225133) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "account_settings", force: :cascade do |t|
    t.bigint "account_id"
    t.float "distance_radius", default: 10.0, null: false
    t.string "unit", default: "km", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["account_id"], name: "index_account_settings_on_account_id"
    t.index ["discarded_at"], name: "index_account_settings_on_discarded_at"
  end

  create_table "accounts", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.bigint "user_id"
    t.string "name"
    t.text "bio"
    t.integer "popularity", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_accounts_on_discarded_at"
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activity_feeds", force: :cascade do |t|
    t.string "type", null: false
    t.string "message", null: false
    t.bigint "created_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_activity_feeds_on_created_by_id"
  end

  create_table "activity_reports", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "local_date"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_session_id"
    t.string "slug"
    t.string "url"
    t.index ["course_session_id"], name: "index_activity_reports_on_course_session_id"
    t.index ["slug"], name: "index_activity_reports_on_slug", unique: true
    t.index ["user_id"], name: "index_activity_reports_on_user_id"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "neighborhood"
    t.string "zip_code"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
    t.index ["discarded_at"], name: "index_addresses_on_discarded_at"
  end

  create_table "assignments", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.date "release_date"
    t.date "due_date"
    t.bigint "course_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.datetime "discarded_at"
    t.string "assigned_role"
    t.datetime "completed_at"
    t.bigint "completed_by"
    t.index ["course_session_id"], name: "index_assignments_on_course_session_id"
    t.index ["discarded_at"], name: "index_assignments_on_discarded_at"
    t.index ["slug"], name: "index_assignments_on_slug", unique: true
  end

  create_table "candidate_contracts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_candidate_contracts_on_slug", unique: true
    t.index ["user_id"], name: "index_candidate_contracts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_categories_on_discarded_at"
  end

  create_table "change_requests", force: :cascade do |t|
    t.bigint "course_session_id", null: false
    t.bigint "requested_by_id", null: false
    t.text "problem"
    t.text "proposed_fix"
    t.string "status", null: false
    t.string "problem_link"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "institution_notes"
    t.string "slug"
    t.string "change_reason"
    t.index ["course_session_id"], name: "index_change_requests_on_course_session_id"
    t.index ["requested_by_id"], name: "index_change_requests_on_requested_by_id"
    t.index ["slug"], name: "index_change_requests_on_slug", unique: true
  end

  create_table "chat_messages", force: :cascade do |t|
    t.bigint "chat_room_id"
    t.bigint "user_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["chat_room_id"], name: "index_chat_messages_on_chat_room_id"
    t.index ["discarded_at"], name: "index_chat_messages_on_discarded_at"
    t.index ["user_id"], name: "index_chat_messages_on_user_id"
  end

  create_table "chat_rooms", force: :cascade do |t|
    t.bigint "course_session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["course_session_id"], name: "index_chat_rooms_on_course_session_id"
    t.index ["discarded_at"], name: "index_chat_rooms_on_discarded_at"
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "course_session_id"
    t.string "contact_type"
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["course_session_id"], name: "index_contacts_on_course_session_id"
    t.index ["slug"], name: "index_contacts_on_slug", unique: true
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_qualifications", force: :cascade do |t|
    t.string "name"
    t.boolean "required", default: false
    t.boolean "is_default", default: false
    t.bigint "course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.datetime "discarded_at"
    t.index ["course_id"], name: "index_course_qualifications_on_course_id"
    t.index ["discarded_at"], name: "index_course_qualifications_on_discarded_at"
    t.index ["slug"], name: "index_course_qualifications_on_slug", unique: true
  end

  create_table "course_qualifications_facilitator_applications", id: false, force: :cascade do |t|
    t.bigint "facilitator_application_id", null: false
    t.bigint "course_qualification_id", null: false
  end

  create_table "course_session_documents", force: :cascade do |t|
    t.bigint "course_session_id"
    t.bigint "uploaded_by_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["course_session_id"], name: "index_course_session_documents_on_course_session_id"
    t.index ["discarded_at"], name: "index_course_session_documents_on_discarded_at"
  end

  create_table "course_session_invitations", force: :cascade do |t|
    t.bigint "course_session_id"
    t.integer "facilitator_id"
    t.integer "faculty_id"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["course_session_id"], name: "index_course_session_invitations_on_course_session_id"
    t.index ["discarded_at"], name: "index_course_session_invitations_on_discarded_at"
  end

  create_table "course_session_urls", force: :cascade do |t|
    t.bigint "course_session_id"
    t.string "url"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["course_session_id"], name: "index_course_session_urls_on_course_session_id"
    t.index ["discarded_at"], name: "index_course_session_urls_on_discarded_at"
  end

  create_table "course_sessions", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "discarded_at"
    t.integer "facilitator_id"
    t.integer "faculty_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "max_baseline"
    t.float "min_baseline"
    t.string "status"
    t.boolean "open", default: false
    t.string "slug"
    t.float "cost", default: 0.0
    t.string "welcome_message"
    t.string "course_run_id"
    t.string "external_ref"
    t.string "assigned_role"
    t.string "activity_range"
    t.string "edify_status"
    t.float "forum_max_baseline"
    t.float "forum_min_baseline"
    t.index ["course_id"], name: "index_course_sessions_on_course_id"
    t.index ["slug"], name: "index_course_sessions_on_slug", unique: true
  end

  create_table "course_watchers", force: :cascade do |t|
    t.bigint "course_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["course_id"], name: "index_course_watchers_on_course_id"
    t.index ["slug"], name: "index_course_watchers_on_slug", unique: true
    t.index ["user_id"], name: "index_course_watchers_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "ref"
    t.string "name"
    t.boolean "online"
    t.boolean "partial_online"
    t.text "description"
    t.text "foci"
    t.text "responsibilities"
    t.string "external_id"
    t.string "image_url"
    t.string "video_url"
    t.string "primary_language"
    t.string "external_ref"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.bigint "institution_id"
    t.integer "primary_language_id"
    t.string "program_level"
    t.string "slug"
    t.string "source"
    t.boolean "synchronized"
    t.string "api_status"
    t.string "availability"
    t.bigint "created_by_id"
    t.string "marketing_url"
    t.string "pacing_type"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "upgrade_deadline"
    t.integer "min_effort"
    t.integer "max_effort"
    t.integer "weeks_to_complete"
    t.float "estimated_hours"
    t.jsonb "enrollment_count", default: [], array: true
    t.jsonb "recent_enrollment_count", default: [], array: true
    t.index ["created_by_id"], name: "index_courses_on_created_by_id"
    t.index ["institution_id"], name: "index_courses_on_institution_id"
    t.index ["primary_language_id"], name: "index_courses_on_primary_language_id"
    t.index ["slug"], name: "index_courses_on_slug", unique: true
  end

  create_table "courses_languages", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "language_id", null: false
  end

  create_table "courses_subjects", id: false, force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "subject_id", null: false
  end

  create_table "courses_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "course_id"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "documents", force: :cascade do |t|
    t.text "description"
    t.string "documentable_type"
    t.integer "documentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "verified_at"
    t.integer "verified_by"
    t.string "file_for"
    t.datetime "discarded_at"
    t.string "slug"
    t.index ["documentable_type", "documentable_id"], name: "index_documents_on_documentable_type_and_documentable_id"
    t.index ["slug"], name: "index_documents_on_slug", unique: true
  end

  create_table "endorsements", force: :cascade do |t|
    t.bigint "facilitator_application_id", null: false
    t.bigint "endorsed_by_id", null: false
    t.datetime "endorsed_at"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["endorsed_by_id"], name: "index_endorsements_on_endorsed_by_id"
    t.index ["facilitator_application_id"], name: "index_endorsements_on_facilitator_application_id"
  end

  create_table "engagement_contracts", force: :cascade do |t|
    t.bigint "engagement_id"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["engagement_id"], name: "index_engagement_contracts_on_engagement_id"
    t.index ["slug"], name: "index_engagement_contracts_on_slug", unique: true
  end

  create_table "engagements", force: :cascade do |t|
    t.bigint "course_session_id"
    t.bigint "user_id"
    t.integer "mediator_id"
    t.string "status"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "sponsor_id"
    t.index ["course_session_id"], name: "index_engagements_on_course_session_id"
    t.index ["slug"], name: "index_engagements_on_slug", unique: true
    t.index ["user_id"], name: "index_engagements_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.bigint "account_id"
    t.string "name"
    t.text "description"
    t.boolean "active", default: true
    t.string "privacy"
    t.date "start_date"
    t.date "end_date"
    t.time "start_time"
    t.time "end_time"
    t.boolean "undefined_end", default: false
    t.string "external_url"
    t.integer "minimum_age"
    t.text "tags", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["account_id"], name: "index_events_on_account_id"
    t.index ["discarded_at"], name: "index_events_on_discarded_at"
  end

  create_table "facilitator_applications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "released_at"
    t.datetime "removed_at"
    t.string "status"
    t.text "cover_letter"
    t.string "reject_reason"
    t.string "posting_type"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "course_session_id"
    t.string "slug"
    t.bigint "approved_by_id"
    t.datetime "approved_at"
    t.bigint "rejected_by_id"
    t.datetime "rejected_at"
    t.index ["course_session_id"], name: "index_facilitator_applications_on_course_session_id"
    t.index ["slug"], name: "index_facilitator_applications_on_slug", unique: true
    t.index ["user_id"], name: "index_facilitator_applications_on_user_id"
  end

  create_table "facilitator_qualifications", force: :cascade do |t|
    t.text "description"
    t.decimal "gpa"
    t.string "qualification_type"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.integer "denied_by"
    t.bigint "institution_id"
    t.string "role"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "employer"
    t.string "other_institution"
    t.integer "verified_by"
    t.datetime "verified_at"
    t.string "slug"
    t.string "major_id"
    t.index ["institution_id"], name: "index_facilitator_qualifications_on_institution_id"
    t.index ["slug"], name: "index_facilitator_qualifications_on_slug", unique: true
    t.index ["user_id"], name: "index_facilitator_qualifications_on_user_id"
  end

  create_table "field_of_studies", force: :cascade do |t|
    t.bigint "study_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_field_of_studies_on_discarded_at"
  end

  create_table "field_of_studies_potential_institutions", id: false, force: :cascade do |t|
    t.bigint "potential_institution_id", null: false
    t.bigint "field_of_study_id", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.string "follower_type", null: false
    t.bigint "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable_type_and_followable_id"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_follows_on_follower_type_and_follower_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name", null: false
    t.string "address_line_one"
    t.string "address_line_two"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "country"
    t.string "nsc_code"
    t.datetime "discarded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "logo_url"
    t.string "slug"
    t.index ["slug"], name: "index_institutions_on_slug", unique: true
  end

  create_table "institutions_subjects", id: false, force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "subject_id", null: false
  end

  create_table "institutions_users", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "institution_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.string "edx_language"
    t.string "slug"
    t.index ["slug"], name: "index_languages_on_slug", unique: true
  end

  create_table "languages_users", id: false, force: :cascade do |t|
    t.bigint "language_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "leads", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.string "source"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_leads_on_discarded_at"
  end

  create_table "learner_applications", force: :cascade do |t|
    t.bigint "learner_id", null: false
    t.bigint "sponsor_id", null: false
    t.bigint "course_session_id", null: false
    t.text "cover_letter"
    t.string "status", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "anonymous", default: false
    t.index ["course_session_id"], name: "index_learner_applications_on_course_session_id"
    t.index ["learner_id"], name: "index_learner_applications_on_learner_id"
    t.index ["sponsor_id"], name: "index_learner_applications_on_sponsor_id"
  end

  create_table "learner_qualifications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "description"
    t.string "qualification_type"
    t.datetime "discarded_at"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_learner_qualifications_on_slug", unique: true
    t.index ["user_id"], name: "index_learner_qualifications_on_user_id"
  end

  create_table "learning_objectives", force: :cascade do |t|
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.datetime "discarded_at"
    t.integer "course_session_id"
    t.index ["discarded_at"], name: "index_learning_objectives_on_discarded_at"
    t.index ["slug"], name: "index_learning_objectives_on_slug", unique: true
  end

  create_table "localizations", force: :cascade do |t|
    t.string "localizable_type"
    t.bigint "localizable_id"
    t.decimal "latitude", precision: 11, scale: 8
    t.decimal "longitude", precision: 11, scale: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_localizations_on_discarded_at"
    t.index ["localizable_type", "localizable_id"], name: "index_localizations_on_localizable_type_and_localizable_id"
  end

  create_table "majors", force: :cascade do |t|
    t.bigint "study_id"
    t.string "major_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_majors_on_discarded_at"
  end

  create_table "password_recoveries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "code"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_password_recoveries_on_discarded_at"
    t.index ["user_id"], name: "index_password_recoveries_on_user_id"
  end

  create_table "potential_institutions", force: :cascade do |t|
    t.string "name"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "email"
    t.string "role", default: [], array: true
    t.string "adjuncts"
    t.string "primary_interest", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_potential_institutions_on_discarded_at"
  end

  create_table "prep_work_items", force: :cascade do |t|
    t.bigint "course_session_id"
    t.bigint "completed_by_id"
    t.datetime "completed_at"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.string "assigned_role"
    t.index ["course_session_id"], name: "index_prep_work_items_on_course_session_id"
    t.index ["discarded_at"], name: "index_prep_work_items_on_discarded_at"
  end

  create_table "referrals", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.boolean "accepted", default: false
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_referrals_on_slug", unique: true
    t.index ["user_id"], name: "index_referrals_on_user_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "access_token", null: false
    t.boolean "change_password"
    t.jsonb "cached_user"
    t.datetime "created_at"
    t.index ["access_token"], name: "index_sessions_on_access_token"
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "sponsor_answers", force: :cascade do |t|
    t.bigint "sponsor_question_id"
    t.bigint "user_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_sponsor_answers_on_slug", unique: true
    t.index ["sponsor_question_id"], name: "index_sponsor_answers_on_sponsor_question_id"
    t.index ["user_id"], name: "index_sponsor_answers_on_user_id"
  end

  create_table "sponsor_questions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["slug"], name: "index_sponsor_questions_on_slug", unique: true
  end

  create_table "sponsorships", force: :cascade do |t|
    t.bigint "sponsor_id", null: false
    t.bigint "learner_id", null: false
    t.datetime "started_at", null: false
    t.datetime "ended_at"
    t.boolean "anonymous", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.index ["learner_id"], name: "index_sponsorships_on_learner_id"
    t.index ["slug"], name: "index_sponsorships_on_slug", unique: true
    t.index ["sponsor_id"], name: "index_sponsorships_on_sponsor_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.string "slug"
    t.index ["slug"], name: "index_subjects_on_slug", unique: true
  end

  create_table "subjects_users", id: false, force: :cascade do |t|
    t.bigint "subject_id", null: false
    t.bigint "user_id", null: false
  end

  create_table "summed_activity_reports", force: :cascade do |t|
    t.bigint "course_session_id"
    t.integer "total_minutes", default: 0
    t.date "activity_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.integer "user_id"
    t.string "category"
    t.index ["course_session_id"], name: "index_summed_activity_reports_on_course_session_id"
    t.index ["discarded_at"], name: "index_summed_activity_reports_on_discarded_at"
  end

  create_table "survey_answers", force: :cascade do |t|
    t.bigint "survey_id"
    t.jsonb "answers", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_answers_on_survey_id"
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "course_session_id"
    t.jsonb "questions", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.string "title"
    t.index ["course_session_id"], name: "index_surveys_on_course_session_id"
    t.index ["discarded_at"], name: "index_surveys_on_discarded_at"
  end

  create_table "system_jobs", force: :cascade do |t|
    t.string "job_name"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_login_entries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at"
    t.index ["user_id"], name: "index_user_login_entries_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid", default: -> { "uuid_generate_v4()" }, null: false
    t.string "email"
    t.string "username"
    t.string "password_digest"
    t.string "uid"
    t.string "provider", default: "api"
    t.boolean "active", default: true
    t.boolean "verified", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "discarded_at"
    t.index ["discarded_at"], name: "index_users_on_discarded_at"
    t.index ["email"], name: "index_users_on_email"
  end

  add_foreign_key "account_settings", "accounts"
  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activity_feeds", "users", column: "created_by_id"
  add_foreign_key "activity_reports", "course_sessions"
  add_foreign_key "assignments", "course_sessions"
  add_foreign_key "chat_messages", "chat_rooms"
  add_foreign_key "chat_rooms", "course_sessions"
  add_foreign_key "contacts", "course_sessions"
  add_foreign_key "course_qualifications", "courses"
  add_foreign_key "course_session_documents", "course_sessions"
  add_foreign_key "course_session_invitations", "course_sessions"
  add_foreign_key "course_session_urls", "course_sessions"
  add_foreign_key "course_watchers", "courses"
  add_foreign_key "courses", "institutions"
  add_foreign_key "endorsements", "users", column: "endorsed_by_id"
  add_foreign_key "engagement_contracts", "engagements"
  add_foreign_key "engagements", "course_sessions"
  add_foreign_key "events", "accounts"
  add_foreign_key "facilitator_applications", "course_sessions"
  add_foreign_key "facilitator_qualifications", "institutions"
  add_foreign_key "learner_applications", "course_sessions"
  add_foreign_key "password_recoveries", "users"
  add_foreign_key "prep_work_items", "course_sessions"
  add_foreign_key "sponsor_answers", "sponsor_questions"
  add_foreign_key "summed_activity_reports", "course_sessions"
  add_foreign_key "survey_answers", "surveys"
  add_foreign_key "surveys", "course_sessions"
end
