Date: Tue, 1 Jun 2004 10:43:43 +0200
From: Santiago Garcia Mantinan <bridge@manty.net>
Subject: Re: [Bridge] Bridging
Message-ID: <20040601084343.GA5090@man.manty.net>
References: <20040531071612.68077.qmail@web41004.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040531071612.68077.qmail@web41004.mail.yahoo.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Yong Chu Eu <ceyong@yahoo.com>
Cc: bridge@osdl.org

Just a quick note for those reading this on the list, version 1.X up to, and
including, 1.0.3 doesn't work on 2.4 kernels, Stephen is looking at that and
there should be a new version :-)

> when i type ./configure then make then make install to bridge-utils-1.0.3,
> but u come out with error said lsysfs cannot found?

Yes, by default new versions of the tools require libsysfs, you'll have to
specify a parameter to configure to build without libsysfs.

> But when i install bridge-utils-0.9.6, it succeedful install but nothing
> come out, i type lsmod, i did not see any brctl

brctl is a tool to control the bridge, not a kernel module, thus it cannot
be seen on lsmod, but if it installed well you can surelly run brctl and get
its help or do a man brctl, ...

BTW: there are bridge-utils packages on most distros out there, maybe you
should install the binary package that comes with your distribution.

Regards...
-- 
Manty/BestiaTester -> http://manty.net
