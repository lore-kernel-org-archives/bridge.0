Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Hx8qcrUpKwD3ZMmHTneVz1r8yqruW/VfpRM/Y8XRyGY=;
 b=B9Cps+y643AFbXupKs1kO8QeclwRqGVmvGQMdYhyChkLb36sepYdR5GTGUdtsfjkIE
 vDpWy4Yg02v+xlFxXe6jmrek0p74Mwx9P/szS+XAAc3shTqhZ9c4mlfrTIyKMXnIR1Bd
 pVljyleLy6/s7oPDvcpvAynOjavIip6odrtM5YHOHv3LrtHAPZtP0R0IUmox7dJ9m8pN
 Xe6esRN3gpU9ajcG1UDyez8pmMHKGnGBcR7E97yUcHfXvaFCVviHXbRO/JDq51XKokpN
 rPpFQwyVosCtnHfSwzV9y7l/By7p6qxzgTtZ3bWpvMw70Xej+ZfwxQIo1ehuENKyU8Nl
 /vpg==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <66dc205f-9f57-61c1-35d9-8712e8d9fe3a@blackwall.org>
References: <20220223172407.175865-1-troglobit@gmail.com>
 <66dc205f-9f57-61c1-35d9-8712e8d9fe3a@blackwall.org>
Date: Thu, 24 Feb 2022 14:59:10 +0100
Message-ID: <878ru0qsb5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH 1/1 net-next] net: bridge: add support for host
	l2 mdb entries
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>

On Thu, Feb 24, 2022 at 13:26, Nikolay Aleksandrov <razor@blackwall.org> wrote:
> On 23/02/2022 19:24, Joachim Wiberg wrote:
>> This patch expands on the earlier work on layer-2 mdb entries by adding
>> support for host entries.
> It would be nice to add a selftest for L2 entries. You can send it as a follow-up.

OK, will do!  It's on my immediate backlog.

Thanks
 /Joachim
 
