Return-Path: <xmCM8KtKk25K@dyweni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 22 Dec 2011 08:25:54 -0600
From: Dyweni - NetDev <xmCM8KtKk25K@dyweni.com>
Message-ID: <b8003b95089e177b00bc7db44700757a@pl1.haspere.com>
Subject: [Bridge] Invalid Argument when adding a bond to a bridge
Reply-To: xmCM8KtKk25K@dyweni.com
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: NetDev <netdev@vger.kernel.org>, Bridge <bridge@lists.linux-foundation.org>, Bonding Devel <bonding-devel@lists.sourceforge.net>

 Hi All,

 I need some help figuring this one out... Whenever I try to add a bond 
 to a
 bridge, I get back an invalid argument error. I've confirmed this on
 3.2-rc6, 3.1.5, 3.0.13, and 2.6.39.4 (haven't checked earlier kernels).

 Here's my setup: 32bit KVM virtual machine with no network cards (... 
 -net
 none ... ).

 I created the bond with: echo "+x" > /sys/class/net/bonding_masters

 I created the bridge with: brctl addbr b

 I try to add the bond to the bridge with: brctl addif b x

-- 
 Thanks,
 Dyweni
