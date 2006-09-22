Date: Fri, 22 Sep 2006 16:24:36 -0700
From: Stephen Hemminger <shemminger@osdl.org>
Message-ID: <20060922162436.21ff5bea@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [ANNOUNCE] bridge-utils 1.2
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org
Cc: netdev@vger.kernel.org, xen-devel@lists.xensource.com

This is a minor release update to the bridge utilities to fix some
build issues and remove the usage of libsysfs. libsysfs wasn't making the
code easier and it was a pain for other build environments.

Also some error messages and spelling fixes, etc.

Download from:
	http://prdownloads.sourceforge.net/bridge/bridge-utils-1.2.tar.gz?download

-- 
Stephen Hemminger <shemminger@osdl.org>
