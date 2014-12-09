#
# Author:: Sunny Gleason (<sunny@thesunnycloud.com>)
# Copyright:: Copyright (c) 2013 Dyn, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

module Dyn
  module Messaging
    class Recipients
      def initialize(dyn)
        @dyn = dyn
      end

      def status(email)
        @dyn.get("#{resource_path}/status", emailaddress: email)
      end

      def statuses(emails_array)
        comma_seperated_emails = emails_array.compact.uniq.join(', ')
        @dyn.get("#{resource_path}/status", emailaddress: comma_seperated_emails)
      end

      def activate(email)
        @dyn.post("#{resource_path}/activate", emailaddress: email)
      end

      private

      def resource_path
        'recipients'
      end
    end
  end
end
