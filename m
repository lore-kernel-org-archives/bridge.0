Message-ID: <405E6CF0.5040900@cox.net>
Date: Sun, 21 Mar 2004 20:34:56 -0800
From: "D@7@k|N&" <dataking@cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Sparc Bridge problems
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hey guys!

I'm having a little trouble with a sprc bridge setup.  I am running SuSe 7.3 for sparc on a Sun Ultra1 Creator3D.
I compiled 2.4.25 kernel with 802.1d Ethernet Bridging support, and installed
bridge-utils 0.9.6.  I've read all of the documentation that I could find (Bridging FAQ and
Bridging HOWTO).  But I still get the following errors:

brctl addbr br0
brctl addif br0 eth0
bridge br0 doesn't exist!

Why not?

brctl addbr br0
device br0 already exists; can't create bridge with the same name

I've found on other mailing-lists that sparc systems require the bridge-utils64 package, but can only find it for Debian.

Any thoughts on what's going on here?  If I compiled the utils from source, shouldn't they be the right ones for my system/kernel?

Any help would be greatly appreciated.

Thanks,
Charlie


