Return-Path: <vvs@parallels.com>
Message-ID: <54DA0EAD.60002@parallels.com>
Date: Tue, 10 Feb 2015 16:59:09 +0300
From: Vasily Averin <vvs@parallels.com>
MIME-Version: 1.0
References: <1378253619-23918-1-git-send-email-linus.luessing@web.de>
	<54D9C4ED.6040601@parallels.com> <20150210114428.GK2489@odroid>
In-Reply-To: <20150210114428.GK2489@odroid>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] bride: IPv6 multicast snooping enhancements
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?TGludXMgTMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Cong Wang <amwang@redhat.com>

On 10.02.2015 14:44, Linus Lüssing wrote:
> Hi Vasily,
> 
> On Tue, Feb 10, 2015 at 11:44:29AM +0300, Vasily Averin wrote:
>> This patch prevent forwarding of ICMPv6 in bridges,
>> so containers/VMs with virtual eth adapters connected in local bridge cannot ping each other via ipv6 (but can do it via ipv4)
> 
> If a host wants to receive packets, then it needs to signalize
> that via MLD. If your host does not do that, then it is expected
> to not receive ICMPv6 echo requests to multicast addresses. An
> exception is ff02::1, that should always work.

Thank you for explanation, seems now I understand finally how it should work.

I'm trying to fix ICMPv6 processing broken in OpenVZ after rebase to last RHEL6u6 kernel.
After some unclear manipulation bridge begins to forward icmp6 NS (fe02::1) into wrong port,
and at present I do not found the reason of this failure.

Thank you,
	Vasily Averin
