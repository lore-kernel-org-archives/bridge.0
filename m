Return-Path: <kuba@kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E6F788236F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE09C82369
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1676085659;
 bh=7jVs7Tz/4ecjvj6H4SeqnLEwHHJGQdIi3lJzgRcYaIE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=gFNSGKYxxeQD30K706H0NPsLlBwC48s6RSk78RUT5Sfs4pXH4YB3MGISFmqVIkVEP
 RuQsRLUxSI+oyPI6sJuOepZPHCR/BlXq5Td+sHY8qKhaDLrpCrmMCYLTnAeKnAOqN1
 NpTQJm/bdKKDDPNcJrP2ZxtV1qmBsctS5gXnArmetVtX08NIaHhYD/fy4ekBBeo7b/
 QtJCcrYS4AgembfTar8YEgYKngSOVh4aYGV3otVRDeuBJRBtnt5QWxk5jyBnoPh+NX
 nObYCwb81wpJBy8E+fiy3/dojGdvCvJvyXDPS1AKoGVFhkcveXwxdgyufLSIs/x5BT
 SKDCZxoMUeAmA==
Date: Fri, 10 Feb 2023 19:20:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20230210192057.4927b002@kernel.org>
In-Reply-To: <20230209071852.613102-4-idosch@nvidia.com>
References: <20230209071852.613102-1-idosch@nvidia.com>
 <20230209071852.613102-4-idosch@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 3/4] bridge: mcast: Move validation to
	a policy
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, edumazet@google.com, mlxsw@nvidia.com, roopa@nvidia.com, pabeni@redhat.com, davem@davemloft.net

On Thu,  9 Feb 2023 09:18:51 +0200 Ido Schimmel wrote:
> +	if (nla_len(attr) != sizeof(struct br_mdb_entry)) {
> +		NL_SET_ERR_MSG_MOD(extack, "Invalid MDBA_SET_ENTRY attribute length");
> +		return -EINVAL;

Well, you're just moving it, but NL_SET_ERR_MSG_ATTR() would be better.
We shouldn't be adding _MOD() in the core implementation of the family.
