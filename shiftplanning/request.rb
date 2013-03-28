require 'shiftplanning/request/sp_module'

class ShiftPlanning
  class Request < ShiftPlanning::Config
    # Setup getters and setters 
    attr_reader(
      :api, :admin, :messaging, :reports, :payroll, :schedule, :timeclock, 
      :staff, :availability, :location, :training, :group, :sales, :dashboard, :terminal
    )
    
    # Constructor 
    #**********************************
    def initialize
      @api = _api.new(SPModule.new('api.methods', 'GET'), SPModule.new('api.config', 'GET'))
      @admin = _admin.new(
        SPModule.new('admin.settings', 'GET', {}, %w(GET UPDATE), {:GET => ['token'], :UPDATE => ['token']}), 
        SPModule.new('admin.details', 'GET', {}, %w(GET UPDATE), {:GET => ['token'], :UPDATE => ['token']}), 
        SPModule.new('admin.files', 'GET', {}, %w(GET), {:GET => 'token'}), 
        SPModule.new('admin.file', 'GET', {}, %w(GET UPDATE DELETE CREATE), {
          :GET => %w(token id), :UPDATE => %w(token id), :DELETE => %w(token id), 
          :CREATE => %W(token filename filedata filelength mimetype)
        }), 
        SPModule.new('admin.backups', 'GET', {}, %w(GET), {:GET => ['token']}),
        SPModule.new('admin.backup', 'GET', {}, %w(GET DELETE CREATE), {:GET => %w(token id), :CREATE => %w(token filename filedata filelength mimetype), :DELETE => %w(token id)}), 
        SPModule.new('admin.nrequests', 'GET', {}, %w(GET), {:GET => %w(token)}), 
        SPModule.new('admin.business', 'GET', {}, %w(GET), {:GET => %w(token)}), 
        SPModule.new('admin.group_perms', 'GET', {}, %w(GET UPDATE), {:GET => %w(token), :UPDATE => %w(token)})
      )
      @messaging = _messaging.new(
        SPModule.new('messaging.messages', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('messaging.message', 'GET', {}, %w(GET CREATE DELETE UPDATE), {
          :GET => %w(token id), :CREATE => %w(token subject message to), :UPDATE => %w(token id), :DELETE => %w(token id)
        }),
        SPModule.new('messaging.shift', 'CREATE', {}, %w(CREATE), {:CREATE => %w(token subject message id)}),
        SPModule.new('messaging.wall', 'GET', {}, %w(GET CREATE DELETE), {:GET => %w(token), :CREATE => %w(token post), :DELETE => %w(token id delete)}),
        SPModule.new('messaging.notice', 'GET', {}, %w(GET UPDATE CREATE DELETE), {
          :GET => %w(token id), :CREATE => %w(token), :UPDATE => %w(token id), :DELETE => %w(token id)
        }),
        SPModule.new('messaging.notices', 'GET', {}, %w(GET), {:GET => %w(token)})
      )
      @reports = _reports.new(
        SPModule.new('reports.schedule', 'GET', {}, %w(GET), {:GET => %w(token start_date end_date type)}),
        SPModule.new('reports.budget', 'GET', {}, %w(GET), {:GET => %w(token start_date end_date)}),
        SPModule.new('reports.timesheets', 'GET', {}, %w(GET), {:GET => %w(token start_date end_date type)}),
        SPModule.new('reports.employee', 'GET', {}, %w(GET), {:GET => %w(token start_date end_date type)}),
        SPModule.new('reports.custom', 'GET', {}, %w(GET), {:GET => %w(token start_date end_date type fields)}),
        SPModule.new('reports.daily_peak_hours_new', 'GET', {}, %w(GET), {:GET => %w(token start_date end_date)}),
        SPModule.new('reports.daily_peak_hours', 'GET', {}, %w(GET), {:GET => %w(token start_date end_date)})
      )
      @payroll = _payroll.new(
        SPModule.new('payroll.report', 'GET', {}, %w(GET), {:GET => %w(token type)}),
        SPModule.new('payroll.ratecards', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('payroll.ratecard', 'GET', {}, %w(GET CREATE DELETE UPDATE), {:GET => %w(token id), :CREATE => %w(token name), :UPDATE => %w(token id), :DELETE => %w(token id)})
      )
      @schedule = _schedule.new(
        SPModule.new('schedule.schedules', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('schedule.schedule', 'GET', {}, %w(GET CREATE UPDATE DELETE), {
          :GET => %w(token id), :CREATE => %w(token name), :UPDATE => %w(token id), :DELETE => %w(token id)
        }),
        SPModule.new('schedule.shifts', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('schedule.shift', 'GET', {}, %w(GET CREATE UPDATE DELETE), {
          :GET => %w(token id), :CREATE => %w(token start_time end_time start_date end_date), :UPDATE => %w(token id), :DELETE => %w(token id)
        }),
        SPModule.new('schedule.shiftapprove', 'GET', {}, %w(GET CREATE UPDATE DELETE), {
          :GET => %w(token id), :CREATE => %w(token id), :UPDATE => %w(token), :DELETE => %w(token id)
        }),
        SPModule.new('schedule.trade', 'GET', {}, %w(GET CREATE UDPATE), {:GET => %w(token id), :CREATE => %w(token shift tradewith reason), :UPDATE => %w(token trade action)}),
        SPModule.new('schedule.trades', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('schedule.tradelist', 'GET', {}, %w(GET), {:GET => %w(token id)}),
        SPModule.new('schedule.tradeswap', 'CREATE', {}, %w(CREATE UPDATE), {:CREATE => %w(token shift swap reason), :UPDATE => %w(token trade action)}),
        SPModule.new('schedule.vacations', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('schedule.vacation', 'GET', {}, %w(GET CREATE UPDATE DELETE), {
          :GET => %w(token id), :CREATE => %w(token start_date end_date), :UPDATE => %w(token id), :DELETE => %w(token id)
        }),
        SPModule.new('schedule.conflicts', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('schedule.copy', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('schedule.clear', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('schedule.restore', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('schedule.wizard', 'GET', {}, %w(GET), {:GET => %w(token from_start from_end to_start to_end)}),
        SPModule.new('schedule.adjust', 'UPDATE', {}, %w(UPDATE), {:UPDATE => %w(token from to budge)}),
        SPModule.new('schedule.fill', 'GET', {}, %w(GET), {:GET => %w(token shifts)}),
        SPModule.new('schedule.publish', 'GET', {}, %w(GET), {:GET => %w(token shifts)}),
        SPModule.new('schedule.requests', 'UPDATE', {}, %w(UPDATE), {:UPDATE => %w(token id type mode)}),
        SPModule.new('schedule.breakrule', 'GET', {}, %w(GET CREATE DELETE), {:GET => %w(token id), :CREATE => %w(token id break paid), :DELETE => %w(token id)}),
        SPModule.new('schedule.shiftrequests', 'CREATE', {}, %w(CREATE), {:CREATE => %w(token shift)})
      )
      @timeclock = _timeclock.new(
        SPModule.new('timeclock.timeclocks', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.timeclock', 'GET', {}, %w(GET CREATE UPDATE DELETE), {:GET => %w(), :CREATE => %w(), :UPDATE => %w(), :DELETE => %w()}),
        SPModule.new('timeclock.clockin', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.preclockin', 'GET', {}, %w(GET CREATE), {:GET => %w(), :CREATE => %w()}),
        SPModule.new('timeclock.preclockins', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.clockout', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.status', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.manage', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.screenshot', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.event', 'CREATE', {}, %w(CREATE UPDATE DELETE), {:CREATE => %w(), :UPDATE => %w(), :DELETE => %w()}),
        SPModule.new('timeclock.timesheets', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.addclocktime', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.savenote', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.forceclockout', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('timeclock.location', 'CREATE', {}, %w(CREATE DELETE), {:CREATE => %w(), :DELETE => %w()}),
        SPModule.new('timeclock.terminal', 'CREATE', {}, %w(DELETE CREATE UPDATE), {:CREATE => %w(), :UPDATE => %w(), :DELETE => %w()})
      )
      @staff = _staff.new(
        SPModule.new('staff.login', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('staff.logout', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('staff.employees', 'GET', {}, %w(GET CREATE), {:GET => %w(), :CREATE => %w()}),
        SPModule.new('staff.employee', 'GET', {}, %w(GET CREATE UPDATE DELETE), {:GET => %w(), :CREATE => %w(), :UPDATE => %w(), :DELETE => %w()}),
        SPModule.new('staff.skills', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('staff.skill', 'GET', {}, %w(GET CREATE UPDATE DELETE), {:GET => %w(), :CREATE => %w(), :UPDATE => %w(), :DELETE => %w()}),
        SPModule.new('staff.customfields', 'GET', {}, %w(GET), {:GET => %w()}),
        SPModule.new('staff.customfield', 'GET', {}, %w(GET CREATE UPDATE DELETE), {:GET => %w(), :CREATE => %w(), :UPDATE => %w(), :DELETE => %w()}),
        SPModule.new('staff.ping', 'GET', {}, %w(CREATE), {:CREATE => %w()})
      )
      @availability = _availability.new(
        SPModule.new('availability.available', 'GET', {}, %w(GET), {:GET => %w(token start_date)}),
        SPModule.new('availability.weekly', 'GET', {}, %w(GET UPDATE DELETE), {:GET => %w(token), :UPDATE => %w(token flag), :DELETE => %w(token start_time end_time)}),
        SPModule.new('availability.future', 'GET', {}, %w(GET CREATE UPDATE DELETE), {
          :GET => %w(token), :CREATE => %w(token start_date), :UPDATE => %w(token id flag), :DELETE => %w(token id)
        }),
        SPModule.new('availability.approve', 'GET', {}, %w(GET UPDATE CREATE), {:GET => %w(token type), :CREATE => %w(token), :UPDATE => %w(token user type action)})
      ) 
      @location = _location.new(
        SPModule.new('location.locations', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('location.location', 'GET', {}, %w(GET CREATE UPDATE DELETE), {
          :GET => %w(token id), :CREATE => %w(token name type), :UPDATE => %w(token id), :DELETE => %w(token id)
        })
      )
      @training = _training.new(
        SPModule.new('training.progress', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('training.sections', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('training.section', 'GET', {}, %w(GET UPDATE DELETE CREATE), {
          :GET => %w(token id), :CREATE => %w(token title), :UPDATE => %w(token id title), :DELETE => %w(token id)
        }),
        SPModule.new('training.modules', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('training.module', 'GET', {}, %w(GET UPDATE DELETE CREATE), {
          :GET => %w(token id), :CREATE => %w(token title), :UPDATE => %w(token id), :DELETE => %w(token id)
        }),
        SPModule.new('training.complete', 'UPDATE', {}, %w(UPDATE), {:UPDATE => %w(token id)}),
        SPModule.new('training.reorder', 'UPDATE', {}, %w(UPDATE), {:UPDATE => %w(token mode)}),
        SPModule.new('training.digital_signature', 'GET', {}, %w(GET), {:GET => %w(token module_id)}),
        SPModule.new('training.comments', 'GET', {}, %w(GET UPDATE), {:GET => %w(token module_id type), :UPDATE => %w(token module_id type)}),
        SPModule.new('training.sync', 'UPDATE', {}, %w(UPDATE), {:UPDATE => %w(token id)}),
        SPModule.new('training.quiz', 'UPDATE', {}, %w(UPDATE), {:UPDATE => %w(token answer)}),
        SPModule.new('training.multiassign', 'UPDATE', {}, %w(UPDATE), {:UPDATE => %w(token assignments modules mode)}),
        SPModule.new('training.tutorial', 'GET', {}, %w(GET), {:GET => %w(token tutorial_id)})
      )
      @group = _group.new(
        SPModule.new('group.accounts', 'GET', {}, %w(GET CREATE), {:GET => %w(token), :CREATE => %w(token accounts)}),
        SPModule.new('group.account', 'GET', {}, %w(GET UPDATE DELETE CREATE), {:GET => %w(token id), :CREATE => %w(token), :UPDATE => %w(token id), :DELETE => %w(token id)}),
        SPModule.new('group.accountsplit', 'CREATE', {}, %w(CREATE), {:CREATE => %w(token location main_user_id)}),
        SPModule.new('group.reports', 'GET', {}, %w(GET), {:GET => %w(token start_date end_date type)})
      )
      @sales = _sales.new(
        SPModule.new('sales.budgets', 'GET', {}, %w(GET), {:GET => %w(token start_date end_date)}),
        SPModule.new('sales.budget', 'GET', {}, %w(GET UPDATE CREATE DELETE), {
          :GET => %w(token start_date end_date), :CREATE => %w(token start_date end_date), :UPDATE => %w(token start_date end_date), :DELETE => %w(token start_date end_date)
        })
      )
      @dashboard = _dashboard.new(
        SPModule.new('dashboard.onnow', 'GET', {}, %w(GET), {:GET => %w(token)}),
        SPModule.new('dashboard.notifications', 'GET', {}, %w(GET), {:GET => %w(token)})
      )
      @terminal = _terminal.new(
        SPModule.new('terminal.login', 'GET', {}, %w(GET), {:GET => %w(token terminal_key)}),
        SPModule.new('terminal.clockin', 'GET', {}, %w(GET), {:GET => %w(token terminal_key)}),
        SPModule.new('terminal.clockout', 'GET', {}, %w(GET), {:GET => %w(token terminal_key)})
      )
    end
    
    private # <<PRIVATE 
      def _api; Struct.new(:methods, :config) end
      def _admin; Struct.new(:settings, :details, :files, :file, :backups, :backup, :nrequests, :business, :group_perms) end
      def _messaging; Struct.new(:messages, :message, :shift, :wall, :notice, :notices) end
      def _reports; Struct.new(:schedule, :budget, :timesheets, :employee, :custom, :daily_peak_hours_new, :daily_peak_hours) end
      def _payroll; Struct.new(:report, :ratecards, :ratecard) end
      def _staff; Struct.new(:login, :logout, :employees, :employee, :skills, :skill, :customfields, :customfield, :ping) end
      def _availability; Struct.new(:available, :weekly, :future, :approve) end
      def _location; Struct.new(:locations, :location) end
      def _group; Struct.new(:accounts, :account, :accountsplit, :reports) end
      def _sales; Struct.new(:budgets, :budget) end
      def _dashboard; Struct.new(:onnow, :notifications) end
      def _terminal; Struct.new(:login, :clockin, :clockout) end
      
      def _schedule 
        Struct.new(
          :schedules, :schedule, :shifts, :shift, :shiftapprove, :trade, :trades, 
          :tradelist, :tradeswap, :vacations, :vacation, :confilcts, :copy, :clear, :restore, :wizard,
          :adjust, :fill, :publish, :requests, :breakrule, :shiftrequests
        )
      end
      
      def _timeclock
        Struct.new(
          :timeclocks, :timeclock, :clockin, :preclockin, :preclockins, :clockout, :status, :manage, 
          :screenshot, :event, :timesheets, :addclocktime, :savenote, :forceclockout, :location, :terminal
        )
      end
      
      def _training
        Struct.new(
          :progress, :sections, :section, :modules, :module, :complete, :reorder, :digital_signature, 
          :comments, :sync, :quiz, :multiassign, :tutorial
        )
      end
    # PRIVATE 
  end
end
