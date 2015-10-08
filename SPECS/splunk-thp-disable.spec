Name:           splunk-thp-disable
Version:        1.0.0
Release:        1%{?dist}
Summary:        Splunk THP (Transactional Huge Pages) Disabler
Group:          Application
License:        GPL
Source0:	%{name}.init
Source1:	%{name}.sysconfig
BuildArch:	noarch

%description
Disabled THP (Transactional Huge Pages)

Requires(post): chkconfig
Requires(preun): chkconfig
# This is for /sbin/service
Requires(preun): initscripts

%install

umask 0022

echo
echo "## INFO: Installing initscript"
echo
install -d -m 755 "$RPM_BUILD_ROOT/%{_initrddir}"
install -m 755 %{SOURCE0} "$RPM_BUILD_ROOT/%{_initrddir}/%{name}"

echo
echo "## INFO: Installing sysconfig"
echo
install -d -m 755 "$RPM_BUILD_ROOT/%{_sysconfdir}/sysconfig"
install -m 644 %{SOURCE1} "$RPM_BUILD_ROOT/%{_sysconfdir}/sysconfig/%{name}"

%post

# This adds the proper /etc/rc*.d links for the script
/sbin/chkconfig --add %{name}
/sbin/service %{name} start

%preun
if [ "$1" = 0 ]; then
    /sbin/service %{name} stop
    /sbin/chkconfig --del %{name}

%postun

%clean
rm -rf $RPM_BUILD_ROOT
	
%files
%attr(-,root,root) %config %{_initrddir}/%{name}
%attr(-,root,root) %config %{_sysconfdir}/sysconfig/%{name}

%doc

%changelog
