Return-Path: <dsahern@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1649718239;
 bh=1zZ/sCx59Z9T/RI6aLTGewKRcoeFMl0lBMQdD/tZeFc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WRs0zPwz6o3hPE9brPkPgJKhOJ08AQEMaDISbOYmvqYQ2uCURJ9abCdB7WlBx1KMH
 f/AMgVJC6rudqomo0+H5Hq6btSOxez3Fo9AcUjPdVX0rkfHMXKq0jGv9TbeJjcKGiC
 EDWzPPk/TN60o3VgrRmqI1zJXBI1+EkOzWSpsY4LMoj3wQweCUXF68RAqjr/05YLSY
 137WI9V7r9oqOlZcz78qYr2RhuquDuw/CUaE5Dhm5IvMkKklWFa47DDrTREFsKO/PE
 pZxKm7uW/j/8FlY/1mhiYNVtQCeGKKPIobFZpo1qxI1CEYqdAuY+1wfiUQHKzSvHCr
 kh2wToR1JBm9g==
Date: Mon, 11 Apr 2022 17:03:56 -0600
From: David Ahern <dsahern@kernel.org>
Message-ID: <20220411230356.GB8838@u2004-local>
References: <20220411172934.1813604-1-razor@blackwall.org>
 <0d08b6ce-53bb-bffa-4f04-ede9bfc8ab63@nvidia.com>
 <c46ac324-34a2-ca0c-7c8c-35dc9c1aa0ab@blackwall.org>
 <92f578b7-347e-22c7-be83-cae4dce101f6@blackwall.org>
 <ca093c4f-d99c-d885-16cb-240b0ce4d8d8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca093c4f-d99c-d885-16cb-240b0ce4d8d8@nvidia.com>
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
To: Roopa Prabhu <roopa@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, idosch@idosch.org, kuba@kernel.org, davem@davemloft.net

On Mon, Apr 11, 2022 at 12:22:24PM -0700, Roopa Prabhu wrote:
> all great points. My only reason to explore RTM_DELNEIGH is to see if we can
> find a recipe to support similar bulk deletes of other objects handled via
> rtm msgs in the future. Plus, it allows you to maintain symmetry between
> flush requests and object delete notification msg types.
> 
> Lets see if there are other opinions.

I guess I should have read the entire thread. :-) (still getting used to
the new lei + mutt workflow). This was my thought - bulk delete is going
to be a common need, and it is really just a mass delete. The GET
message types are used for dumps and some allow attributes on the
request as a means of coarse grain filtering. I think we should try
something similar here for the flush case.
