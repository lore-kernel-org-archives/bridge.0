Return-Path: <stephen@networkplumber.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 83D8560B14
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 814F960A64
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20210112.gappssmtp.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RDU0jrNVQ4Bx2dNkHpgBN29LnYUs6yNV5udmthSaank=;
 b=q4mwlr5nEI0etnmuPLJgbcMHZDwf7lSfWfc4jHHdBlXQtZbEzqntm+VHMUTQGJV6GP
 XqwGbWmkklfDDdhT8UOqQ3TrtGJtDfcZ+p621saVuAb7rsCrSQFsz9Hm5Y942IjAnAM0
 YCd38GBd/cGV3FOEwfj1zmwBfv69ImR55tVKV85e5Bhpwf883U1rEu0LwxPFAKfLQ6ba
 If46yJUg/nJcUgZMrQK8AAw4ytMm9yvVDpuZT/pr05NLd0EGRH7qnuve9tG9BPcT1tf2
 QMf5sjoaeMHaH4AMpQN2V3dspAbrdHD0d34sINR1FoCqIKZgXiion7E7e1C4moM/p5Nk
 Kxgw==
Date: Thu, 26 Jan 2023 11:18:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20230126111843.2544f7d1@hermes.local>
In-Reply-To: <8886e11bde5874305a26c0b7dc397923a1d5a794.1674752051.git.petrm@nvidia.com>
References: <cover.1674752051.git.petrm@nvidia.com>
 <8886e11bde5874305a26c0b7dc397923a1d5a794.1674752051.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 01/16] net: bridge: Set
 strict_start_type at two policies
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Eric Dumazet <edumazet@google.com>, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Thu, 26 Jan 2023 18:01:09 +0100
Petr Machata <petrm@nvidia.com> wrote:

>  static const struct nla_policy br_port_policy[IFLA_BRPORT_MAX + 1] = {
> +	[IFLA_BRPORT_UNSPEC]	= { .strict_start_type =
> +					IFLA_BRPORT_MCAST_EHT_HOSTS_LIMIT + 1 },

Is the original IFLA_BRPORT a typo? ETH not EHT
