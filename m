Date: Tue, 8 Jun 2004 11:24:30 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-Id: <20040608112430.794f7fcf@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [ANNOUNCE] bridge-utils-1.0.4
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org

Released a new version of bridge utilities that supports both new 2.6.7
interface and older 2.6/2.4 releases.  The only changes since 1.0 were
internal to fix compatibility issues. 

The tarball can be downloaded from:
	http://prdownloads.sourceforge.net/bridge


Getting full functionality requires a build system with:
	- libsysfs from the sysfsutils package 
	  http://linux-diag.sourceforge.net/Sysfsutils.html
	- kernel (and headers) from 2.6.7-rc1 or later

Note: libsysfs has not been fully integrated by the main linux vendors.
So producing a full functional package is not possible with the default spec 
file.

The utilities will build (and run) on earlier systems it will just default to 
the old interface and which doesn't have 32/64 bit compatibility.
