Message-ID: <41B14B1D.6040200@osdl.org>
Date: Fri, 03 Dec 2004 21:29:01 -0800
From: Stephen Hemminger <shemminger@osdl.org>
MIME-Version: 1.0
Subject: Re: [Bridge] how to install
References: <BAY18-F104A665A24BD9E38136E54D0B10@phx.gbl>
In-Reply-To: <BAY18-F104A665A24BD9E38136E54D0B10@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Clark Edwards <clarkeboss@hotmail.com>
Cc: bridge@osdl.org

> Hi Im new to Linux and I found out about http://bridge.sf.net from a magazine that I subscribe to. It explains everything about setting it up bridges, but not how to install the package from the site. I ran ./configure, which went fine, and I tried to run ./install-sh, but it keeps asking for a destination. Currently Im running FC3 and I know the kernel is 2.6 or highter on FC3 so shouldn't the patch be added by default? Please help.
> 
> Thanks,
> Clark 

In almost all new distro's the bridging is already compiled in the 
kernel and the utilities are available in the package management system 
as bridge-utils.  This is true for Redhat based distro's like Fedora as 
well as SuSe, Debian and Gentoo. So you should be able to setup
a bridge with the brctl command without any additional special effort.

Also, the 2.6 distributions like Fedora have the Ethernet Bridge
tables (ebtables) for firewall support as well.
