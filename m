From: Alexis Huxley <ahuxley@gmx.net>
Date: Sat, 18 Oct 2008 20:05:10 +0000 (UTC)
Message-ID: <slrngfkgbm.9rb.ahuxley@dione.no-ip.org>
References: <slrngf7br4.5fa.ahuxley@dione.no-ip.org>
	<fed120860810131543w7a0ae9f7wf565d8dc10b06447@mail.gmail.com>
	<slrngfb6f9.ses.ahuxley@dione.no-ip.org>
	<fed120860810150738ob587c59u7dde88f1b02896e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: news <news@ger.gmane.org>
Subject: Re: [Bridge] pinging other side (normal bridge ok,
	anonymous bridge not ok)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

> Is veth1 up? (Maybe you need "ifconfig veth1 up".) You shouldn't need
> the iptables line unless you have other iptables stuff that might
> potentially block it. And there are some emails on the web referring
> to issues with iptables conntrack and veth.

Well, as kind of predicted by everybody, I eventually switched to putting
an IP address on br0. The reason was that when I configured tap0/eth0
in the VM then masquerading did not work correctly; the first ping from
inside the VM to the internet worked, but then immediately it stopped.
I did some googling and it seemed not an uncommon problem, but a quick
test of putting an IP on br0 immediately solved the problem. Thanks
again for the all the very good and speedy advice I was given!

Alexis

