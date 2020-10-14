Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1602718017;
 bh=aJtLUT5CUqccTM2pkrFn/NwRFqdAj1DcJprXwjRRsh0=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=cwbBqOsazetMElUlWGrNzzYcUBOpha8aLsVcHn5DAX4zgDpW8YjqLw9ZlOU8et3We
 2d6oRpe5obXv64sp0VcDx6QjOmCRsd0Emc9M+qSNHq54K1RtYNGivqabiWxiUg+v7y
 dHcbommzec42eZbBZU0pFf56yHMa0MiByTuTfkBc=
Date: Wed, 14 Oct 2020 16:26:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20201014162655.3cbc8664@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
In-Reply-To: <20201012140428.2549163-7-henrik.bjoernlund@microchip.com>
References: <20201012140428.2549163-1-henrik.bjoernlund@microchip.com>
 <20201012140428.2549163-7-henrik.bjoernlund@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v5 06/10] bridge: cfm: Kernel space
 implementation of CFM. CCM frame RX added.
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

On Mon, 12 Oct 2020 14:04:24 +0000 Henrik Bjoernlund wrote:
> +	/* This CCM related status is based on the latest received CCM PDU. */
> +	u8 port_tlv_value; /* Port Status TLV value */
> +	u8 if_tlv_value; /* Interface Status TLV value */
> +
> +	/* CCM has not been received for 3.25 intervals */
> +	bool ccm_defect;
> +
> +	/* (RDI == 1) for last received CCM PDU */
> +	bool rdi;
> +
> +	/* Indications that a CCM PDU has been seen. */
> +	bool seen; /* CCM PDU received */
> +	bool tlv_seen; /* CCM PDU with TLV received */
> +	/* CCM PDU with unexpected sequence number received */
> +	bool seq_unexp_seen;

Please consider using a u8 bitfield rather than a bunch of bools,
if any of this structures are expected to have many instances. 
That'd save space.
