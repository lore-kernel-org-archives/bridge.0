Date: Tue, 17 Apr 2007 12:31:35 -0700 (PDT)
Message-Id: <20070417.123135.56861973.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <4624B44A.9040509@sw.ru>
References: <4624B44A.9040509@sw.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [BRIDGE] Unaligned access on IA64 when comparing
 ethernet addresses
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: xemul@sw.ru
Cc: netdev@vger.kernel.org, bridge@lists.osdl.org, devel@openvz.org

From: Pavel Emelianov <xemul@sw.ru>
Date: Tue, 17 Apr 2007 15:49:30 +0400

> From: Evgeny Kravtsunov <emkravts@openvz.org>
> 
> compare_ether_addr() implicitly requires that the addresses
> passed are 2-bytes aligned in memory.
> 
> This is not true for br_stp_change_bridge_id() and
> br_stp_recalculate_bridge_id() in which one of the addresses
> is unsigned char *, and thus may not be 2-bytes aligned.
> 
> Signed-off-by: Evgeny Kravtsunov <emkravts@openvz.org>
> Signed-off-by: Kirill Korotaev <dev@openvz.org>
> Signed-off-by: Pavel Emelianov <xemul@openvz.org>

Patch applied, thank you.
