Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605998515;
 bh=qomVMm2MeRDCKHvedwhIgYBadhiY7UIQ36rqjlMxvkM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=BDnmp4j34qJ0g/oajusdvGqiqXHQUgSg7prTt+uOVdh9jJszcS8aZ4ZDFV0ASgDSU
 +1Vee89nbbvUS8i2Oo63pjPA6spHEta2mVl3ChF5Tn0JCQWEAL4dZCWbL85ot4f+QA
 ykFT6zvQsMGa4ixgfE3AbYRa3Bka/WlyHn3AN9rU=
Date: Sat, 21 Nov 2020 14:41:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201121144154.03696203@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <9bad2be2-fd84-7c6e-912f-cee433787018@gmail.com>
References: <9bad2be2-fd84-7c6e-912f-cee433787018@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: switch to net core
 statistics counters handling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: bridge@lists.linux-foundation.org, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>

On Fri, 20 Nov 2020 12:22:23 +0100 Heiner Kallweit wrote:
> Use netdev->tstats instead of a member of net_bridge for storing
> a pointer to the per-cpu counters. This allows us to use core
> functionality for statistics handling.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied, thanks!
