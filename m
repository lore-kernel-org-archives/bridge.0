Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649712909;
 bh=uzR0CfSeFc1uxi4hWTAJ9S7h44rksyP8EXFSTLFItig=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Z/gDK6zxT/FGrti/KC8BzNEPu8XW9C50vyFvwyxn+MDcWmEJkKS93H1kbajaHXBcH
 WqIdTJvtymyykeNd5+6PrTq3L+K1Qm3wvYQnZ1QTH7l7upjteH8xsRtThjtfRVoTFS
 o5xjjYh3okAj+U4qvrbVdDytxX+M3b8WmaYFIolHRScQd08abmS9gFuM6l4lwXaZ67
 sI9dOLEddxsbhAoUaGBsPLGk+wQKvgXFbiOCMmaoplWays0b1jjgPocXi7S+SczkYk
 YMg1wfeeNTith10QE1lxF7NoKCehORLiYB+tX2eteqEtbg746lluEskw6TiF3C5k4t
 4xjTj9HjbD1Fw==
Date: Mon, 11 Apr 2022 14:35:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220411143508.0592f60e@kernel.org>
In-Reply-To: <d47fe5e3-2820-196d-b375-2bf98cd784d3@blackwall.org>
References: <20220411172934.1813604-1-razor@blackwall.org>
 <0d08b6ce-53bb-bffa-4f04-ede9bfc8ab63@nvidia.com>
 <c46ac324-34a2-ca0c-7c8c-35dc9c1aa0ab@blackwall.org>
 <92f578b7-347e-22c7-be83-cae4dce101f6@blackwall.org>
 <ca093c4f-d99c-d885-16cb-240b0ce4d8d8@nvidia.com>
 <20220411124910.772dc7a0@kernel.org>
 <3c25f674-d90b-7028-e591-e2248919cca9@blackwall.org>
 <20220411134857.3cf12d36@kernel.org>
 <d47fe5e3-2820-196d-b375-2bf98cd784d3@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/8] net: bridge: add flush
 filtering support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: idosch@idosch.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, Roopa Prabhu <roopa@nvidia.com>

On Tue, 12 Apr 2022 00:17:14 +0300 Nikolay Aleksandrov wrote:
> > Yup, basically the policy is defined in the core, so the types are
> > known. We can extract the fields from the message there, even if 
> > the exact meaning of the fields gets established in the callback.
> 
> That sounds nice, but there are a few catches, f.e. some ndo_fdb implementations
> check if attributes were set, i.e. they can also interpret 0, so it will require
> additional state (either special value, bitfield or some other way of telling them
> it was actually present but 0).
> Anyway I think that is orthogonal to adding the flush support, it's a nice cleanup but can
> be done separately because it will have to be done for all ndo_fdb callbacks and I
> suspect the change will grow considerably.
> OTOH the flush implementation via delneigh doesn't require a new ndo_fdb call way,
> would you mind if I finish that up without the struct conversion?

Not terribly, go ahead.
