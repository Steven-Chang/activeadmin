# frozen_string_literal: true
require "rails_helper"

RSpec.describe ActiveAdmin::Views::StatusTag do
  describe "#status_tag" do
    # Helper method to build StatusTag objects in an Arbre context
    def status_tag(*args)
      render_arbre_component(status_tag_args: args) do
        status_tag(*assigns[:status_tag_args])
      end
    end

    subject { status_tag(nil) }

    describe "#tag_name" do
      subject { super().tag_name }
      it { is_expected.to eq "span" }
    end

    context "when status is 'completed'" do
      subject { status_tag("completed") }

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag") }
      end

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq "Completed" }
      end
    end

    context "when status is 'in_progress'" do
      subject { status_tag("in_progress") }

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag") }
      end

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq "In Progress" }
      end
    end

    context "when status is 'In progress'" do
      subject { status_tag("In progress") }

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag") }
      end

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq "In Progress" }
      end
    end

    context "when status is an empty string" do
      subject { status_tag("") }

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag") }
      end

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq "" }
      end
    end

    context "when status is 'false'" do
      subject { status_tag("false") }

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag", "no") }
      end

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq("No") }
      end
    end

    context "when status is false" do
      subject { status_tag(false) }

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag", "no") }
      end

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq("No") }
      end
    end

    context "when status is nil" do
      subject { status_tag(nil) }

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag", "unset") }
      end

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq("Unknown") }
      end

      describe "with locale override" do
        around do |example|
          with_translation %i[active_admin status_tag unset], "Unspecified" do
            example.run
          end
        end

        describe "#class_list" do
          subject { super().class_list.to_a }
          it { is_expected.to contain_exactly("status_tag", "unset") }
        end

        describe "#content" do
          subject { super().content }
          it { is_expected.to eq("Unspecified") }
        end
      end
    end

    context "when status is 'Active' and class is 'ok'" do
      subject { status_tag("Active", class: "ok") }

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq "Active" }
      end

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag", "ok") }
      end
    end

    context "when status is 'Active' and label is 'on'" do
      subject { status_tag("Active", label: "on") }

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq "on" }
      end

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag") }
      end
    end

    context "when status is 'So useless', class is 'woot awesome' and id is 'useless'" do
      subject { status_tag("So useless", class: "woot awesome", id: "useless") }

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq "So Useless" }
      end

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag", "woot", "awesome") }
      end

      describe "#id" do
        subject { super().id }
        it { is_expected.to eq "useless" }
      end
    end

    context "when status is set to a Fixnum" do
      subject { status_tag(42) }

      describe "#content" do
        subject { super().content }
        it { is_expected.to eq "42" }
      end

      describe "#class_list" do
        subject { super().class_list.to_a }
        it { is_expected.to contain_exactly("status_tag") }
      end
    end
  end
end
