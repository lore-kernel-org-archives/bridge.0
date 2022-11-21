Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 56AC3409B6
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 64D5F40306
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669061884;
 bh=IhNl1vJm3VXqLz/ACfcWWRbRVPnFw5gG6KxRJkVvCnA=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=lxUWsUEPCrFrZwmJ6lNTMZOQFI44VAboWP7tjFx/pVRPWovDYI4i5cPpy/6KUJGNg
 OI4+n/0mmTC1k7r98QA+zMbNSZuulwXCQPpP0tN/NedQjlCcjv3qNodgraUNJzkb1k
 b0greRQNwn4uhMPxVMJlD0x71Iu05YKJlsVK817AEVr2WdWdEkLyJtkhyArjGEMA3u
 kltB4rJmyfEj/C1p6c5lo0k1O/Aqf2K9nANgcCSqLIAlImpdUMzmK0cg5Bn8ZBF7U0
 JXT+ZYBP65Dk4te31iG353KqFaUQnVVnxcr8NrDyADFAshMSeMn/6WT/K3fUauGbXz
 AysDyZtShvHdA==
Date: Mon, 21 Nov 2022 12:18:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20221121121803.31962489@kernel.org>
In-Reply-To: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/5] kobject: make kobject_get_ownership() take
 a constant kobject *
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-nfs@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Chuck Lever <chuck.lever@oracle.com>, Anna Schumaker <anna@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Paolo Abeni <pabeni@redhat.com>, Trond Myklebust <trond.myklebust@hammerspace.com>

On Mon, 21 Nov 2022 10:46:45 +0100 Greg Kroah-Hartman wrote:
> The call, kobject_get_ownership(), does not modify the kobject passed
> into it, so make it const.  This propagates down into the kobj_type
> function callbacks so make the kobject passed into them also const,
> ensuring that nothing in the kobject is being changed here.
> 
> This helps make it more obvious what calls and callbacks do, and do not,
> modify structures passed to them.

Acked-by: Jakub Kicinski <kuba@kernel.org>
