Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E2D384182C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8597E4177A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1695298398; x=1695384798; bh=qL6/VmfuEG0N5
 xc6Mz2PvEm3VWqhSA+Pyx12f0FNgWU=; b=NNL8lLZ+nJLyfc6TshaXc4SDbglQp
 a5ODaObdGtjszpBwKJ0Noyh3s/ouKVzOk3ISKCOGJ3XNBvbqe5AeN/048pZRLjiv
 iBeXMcn5Gi7b6wms38bJmdhePlZtGCQ+5HjCoS3OQvYf2yjeN0DWol9H/ihvIlDs
 B1BHuUigB92bXlPuGOFtLqzAKW3g4AEQYixtrwoJIEpt6B7/FO+9wvNzOBG2L5hx
 sswKQwV9JYGbLdkR2oUkpP+YqpSyQzc6UG1sXviI8XOuUUXYG6ogPgML+mfJlpO0
 qq9W6KkzK9vIs9UL/dRRcEqKyy6fVp8LwO6Gcl48X8QEQG6hrxKy0BQMA==
Date: Thu, 21 Sep 2023 15:13:12 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <ZQwzWINOPagvLgbS@shredder>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919-fdb_limit-v4-1-39f0293807b8@avm.de>
Subject: Re: [Bridge] [PATCH net-next v4 1/6] net: bridge: Set
 BR_FDB_ADDED_BY_USER early in fdb_add_entry
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

On Tue, Sep 19, 2023 at 10:12:48AM +0200, Johannes Nixdorf wrote:
> In preparation of the following fdb limit for dynamically learned entries,
> allow fdb_create to detect that the entry was added by the user. This
> way it can skip applying the limit in this case.
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
