Return-Path: <troglobit@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=Xa6MAq+rNUf44zva/0KAJya5lpKaHjn2wMQpnlHghgw=;
 b=Yj4+pap66cqOlKxhRjNnfnD8zWcxf9YREa3tXAn3vzk/YeFZpnz7dviOGt7ZAKeb9o
 oMIIIq+A++0UOeejViTbqKHEu26hfJE00VLuqcb4yIu2XjJ0YMycsrtJxk/wsWNyTAqy
 o83gkRGSJlHfehzmD255N8UOuhOAkuvbUK5rvnN1IUCJX+3o1QnZODnLOySkS66Kym7t
 6osWwVorc5sMDjR23T+WRe1wIpWQVe9zInGohVsDMs9An2dkT7JJOiRveHrRFAuLfkXP
 n1+rN8N0bWWRuzL63I3mUuLqXiSIZ9snq4/CaqkDfrRJKyKePWFiHdYr2SDonnJEZO08
 yeYw==
From: Joachim Wiberg <troglobit@gmail.com>
In-Reply-To: <20220224080611.4e32bac3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20220223172407.175865-1-troglobit@gmail.com>
 <66dc205f-9f57-61c1-35d9-8712e8d9fe3a@blackwall.org>
 <20220224080611.4e32bac3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Date: Thu, 24 Feb 2022 17:29:35 +0100
Message-ID: <875yp4qlcg.fsf@gmail.com>
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
To: Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S . Miller" <davem@davemloft.net>, Roopa Prabhu <roopa@nvidia.com>

On Thu, Feb 24, 2022 at 08:06, Jakub Kicinski <kuba@kernel.org> wrote:
> On Thu, 24 Feb 2022 13:26:22 +0200 Nikolay Aleksandrov wrote:
>> On 23/02/2022 19:24, Joachim Wiberg wrote:
>> > This patch expands on the earlier work on layer-2 mdb entries by adding
>> > support for host entries.
>> It would be nice to add a selftest for L2 entries. You can send it as a follow-up.
> Let's wait for that, also checkpatch says you need to balance brackets
> to hold kernel coding style.

Jakub, by "wait for that" do you mean you'd prefer I add the selftests
to this?  Otherwise I'll send a v2 with the style fixes.

Best regards
 /Joachim
 
