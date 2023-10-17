Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9532681FF4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EEF0081FE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm3; t=1697540803; x=1697627203; bh=C2g91EpF8bnTE
 31MfUeHv6PZqy/bsGdqol8WloDU6eA=; b=KZY8H3h/tBfdYVyxwK6V9SBOE4PmN
 pDfZ7iPTqILvMnmOAYaS6vTd50ShLLE681pmAYgcwKBB7IPbjp8Gj7UIGso5KuDc
 AtQibc8s6ESRmgLDWC6ahvcl9DnDaC64XFR3EqRikoEMsOFKZ/sY3KnyTE2J6EQD
 zNU7thKlnVWnUH75QTzwExR70jw0ZxYEgNg7ZHh1FCc6LfEHecRAz9jDswzIyZCt
 POKzNeguHFE4pbUSbUSF0I93PDJHf0BiqNiMPm2WfiucrUWD8k1KSW5nlXnUvvea
 75ozhkM7xUHDBD0e7urS9GtsVUCaKuLbXDFGpPWPRzYU9MxX+krQ3F15w==
Date: Tue, 17 Oct 2023 14:06:39 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <ZS5qv6WEv5J1tYTU@shredder>
References: <20231016-fdb_limit-v5-0-32cddff87758@avm.de>
 <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-fdb_limit-v5-4-32cddff87758@avm.de>
Subject: Re: [Bridge] [PATCH net-next v5 4/5] net: bridge: Set
 strict_start_type for br_policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Johannes Nixdorf <jnixdorf-oss@avm.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Mon, Oct 16, 2023 at 03:27:23PM +0200, Johannes Nixdorf wrote:
> Set any new attributes added to br_policy to be parsed strictly, to
> prevent userspace from passing garbage.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
