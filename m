Return-Path: <cwang@twopensource.com>
MIME-Version: 1.0
In-Reply-To: <56868207.rHBDZL3pbk@wuerfel>
References: <56868207.rHBDZL3pbk@wuerfel>
Date: Tue, 13 Jan 2015 11:25:45 -0800
Message-ID: <CAHA+R7NfZMRMJ2=pq-VYU_FRdcCheAYu9OW6Hj9fwB0mcT7Xng@mail.gmail.com>
From: Cong Wang <cwang@twopensource.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Bridge] [PATCH] bridge: only provide proxy ARP when
	CONFIG_INET is enabled
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Arnd Bergmann <arnd@arndb.de>
Cc: netdev <netdev@vger.kernel.org>, Kyeyoon Park <kyeyoonp@codeaurora.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, David Miller <davem@davemloft.net>

On Tue, Jan 13, 2015 at 6:10 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> When IPV4 support is disabled, we cannot call arp_send from
> the bridge code, which would result in a kernel link error:
>
> net/built-in.o: In function `br_handle_frame_finish':
> :(.text+0x59914): undefined reference to `arp_send'
> :(.text+0x59a50): undefined reference to `arp_tbl'
>
> This makes the newly added proxy ARP support in the bridge
> code depend on the CONFIG_INET symbol and lets the compiler
> optimize the code out to avoid the link error.
>

Not sure how much sense to make CONFIG_BRIDGE depend
on CONFIG_INET, at least CONFIG_BONDING does.
