Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=dtZ1mF4hdj+0Z+hZEALFB26LiN0+tKFfPeW9FwS8rrM=;
	b=YMBPsEV5RZMoZOGTh+YwvyUwB+wiaTDRDpm2/AjNsI+wy9EN5RRtdL3Ajx9GeB0tO3
	XQ8TY6gRPiv2SjsfY6OrpbwIRe1uDkKANqX5ZNjsya4xOfck2b3ZsUPRSSSRzib4uIw1
	krVprrE5ecjDi44/8neU6V8s4fP0B7qQsSkiw=
References: <1465294457-2785-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5756AC53.70406@cumulusnetworks.com>
Date: Tue, 7 Jun 2016 13:13:23 +0200
MIME-Version: 1.0
In-Reply-To: <1465294457-2785-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] bridge: Don't insert unnecessary local fdb
 entry on changing mac address
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>, "David S. Miller" <davem@davemloft.net>, Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On 06/07/2016 12:14 PM, Toshiaki Makita wrote:
> The missing br_vlan_should_use() test caused creation of an unneeded
> local fdb entry on changing mac address of a bridge device when there is
> a vlan which is configured on a bridge port but not on the bridge
> device.
> 
> Fixes: 2594e9064a57 ("bridge: vlan: add per-vlan struct and move to rhashtables")
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---

Good catch,

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


