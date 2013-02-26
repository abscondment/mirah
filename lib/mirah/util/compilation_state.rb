# Copyright (c) 2010 The Mirah project authors. All Rights Reserved.
# All contributing project authors may be found in the NOTICE file.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'bitescript'

module Mirah
  module Util
    class CompilationState
      def initialize
        @save_extensions = true
        set_jvm_version ENV_JAVA['java.specification.version']
      end

      attr_accessor :verbose, :destination
      attr_accessor :version_printed
      attr_accessor :help_printed
      attr_accessor :save_extensions
      attr_accessor :running
      alias running? running
      attr_accessor :compiler_class
      attr_accessor :args
      attr_accessor :command
      attr_accessor :loggers

      attr_accessor :classpath, :bootclasspath
      attr_reader :target_jvm_version

      def set_jvm_version(ver_str)
        @target_jvm_version = ver_str
        @bytecode_version = case ver_str
        when '1.4' then BiteScript::JAVA1_4
        when '1.5' then BiteScript::JAVA1_5
        when '1.6' then BiteScript::JAVA1_6
        when '1.7' then BiteScript::JAVA1_7
        else
          $stderr.puts "invalid bytecode version specified: #{ver_str}"
        end
        BiteScript.bytecode_version = @bytecode_version
      end

      def supports_invokedynamic?
        @bytecode_version == BiteScript::JAVA1_7
      end
    end
  end
end
