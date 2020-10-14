Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602718220;
 bh=vyv1Lw21EZsvgtDr0IaKBBfPkAhRje6PnLiOpTq5E5o=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=f9mHYFDstQRP7bqIKfSnesVOKCUWUPIUOuPPlhYlDUkXX0Xvu8NNd4GIgqQTAh1B6
 cbMiV3FE1FovKuPzzmIqLwQKKV5wvUAjhrGm6lfxBj8Xgd/6S+U0dv0LcIGvzgq5Zy
 thgbgr+xtvbqaRPR4J+ibbFJ2O1gUfSk4r0fgrtE=
Date: Wed, 14 Oct 2020 16:30:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201014163018.0c2a4fc7@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201012140428.2549163-5-henrik.bjoernlund@microchip.com>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-5-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 04/10] bridge: cfm: Kernel space
 implementation of CFM. MEP create/delete.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

On Mon, 12 Oct 2020 14:04:22 +0000 Henrik Bjoernlund wrote:
> +	if (config->mdlevel > 7) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "MD level is invalid");
> +		return -EINVAL;
> +	}
> +	/* The MEP-ID is a 13 bit field in the CCM PDU identifying the MEP */
> +	if (config->mepid > 0x1FFF) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "MEP-ID is invalid");
> +		return -EINVAL;
> +	}

If I'm reading patch 7 correctly these parameters come from netlink,
right? In that case please use the netlink policies to check things
like ranges or correct values.
