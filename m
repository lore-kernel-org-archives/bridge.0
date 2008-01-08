Date: Tue, 8 Jan 2008 08:56:07 -0800
From: Stephen Hemminger <shemminger@linux-foundation.org>
Message-ID: <20080108085607.37ab168f@deepthought>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [Bridge] [ANNOUNCE] bridge-utils 1.4
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@linux-foundation.org
Cc: netdev@vger.kernel.org

Minor update to bridge-utils. Mostly fixing bugs in usage of sysfs.

Release tarball:
  http://downloads.sourceforge.net/bridge/bridge-utils-1.4.tar.gz

Alon Bar-Lev (1):
      Allow bridge-utils to run when no TCP/IP is available

Denys Vlasenko (1):
      fix use of sysfs (affects 32/64 bit compat)

Jeremy Jackson (1):
      Fix parsing of port_id's (hex).

Stephen Hemminger (3):
      Add ignore for generated files.
      Update gitignore
      Use linux/if.h rather than net/if.h


-- 
Stephen Hemminger <stephen.hemminger@vyatta.com>
