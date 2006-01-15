Date: Sun, 15 Jan 2006 20:22:14 +0100
From: Santiago Garcia Mantinan <bridge@manty.net>
Message-ID: <20060115192213.GA12659@pul.manty.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] bridge-utils and sysfsutils version 2.0.0
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi!

I have not read about any work on this on the list till now, I was wondering
if somebody had worked out this, as it seems that bridge-utils need a little
work to get adapted to the new libsysfs version.

What happens with bridge-utils version 1.0.6 is that if you try to compile
them against version 2.0.0 they detect the libsysfs headers but then don't
find the sysfs_open_directory function as this seems to be removed in the
new api, so bridge-utils gets built without sysfs support.

Anybody working on this or any plans to work on it?

Regards...
-- 
Manty/BestiaTester -> http://manty.net
