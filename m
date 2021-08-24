Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629849129;
 bh=Y+YdA+2CMsgqdmmpnQ4ORVcuiQP93MiMTcXGC05a0x8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=P76SmD/+8qyjtGB124/Yo5+ywHRqyZ/spCL7h8+blkI86gF0FXQs/HUJJQKpLiLkB
 5RhnTM7hVGcPauQvKe9vziKnZGWmCYjdD+tuW4vpXJ92WHG54t5ZP/mnfUizL8CcQW
 QZdvcpTD9z/yHCQjEDJULv8FWPSkrLXW5tFYHv9FKSDoqnVRncqLZkux0n++Ubo+Qr
 VyG5U5nnrWbBdqppsHYfnIjMAlucgE2zy/ypEtF8GXHuP7mJvPIAjimAfYoIeIKh7a
 Y/F7kc3fbApgHP9tJuRaH+CL0EDx9WuVA7IlO894qEzaDHqNbVTjydrfD5xjE7R+GP
 6sMorJjKV8UPA==
Date: Tue, 24 Aug 2021 16:52:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210824165208.36944d77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <d37ff915-6d94-2d22-9e93-46b374fc47d7@nvidia.com>
References: <20210823102118.17966-1-l4stpr0gr4m@gmail.com>
 <d37ff915-6d94-2d22-9e93-46b374fc47d7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next] net: bridge: change return type of
 br_handle_ingress_vlan_tunnel
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>, Kangmin Park <l4stpr0gr4m@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>

On Mon, 23 Aug 2021 13:25:20 +0300 Nikolay Aleksandrov wrote:
> On 23/08/2021 13:21, Kangmin Park wrote:
> > br_handle_ingress_vlan_tunnel() is only referenced in
> > br_handle_frame(). If br_handle_ingress_vlan_tunnel() is called and
> > return non-zero value, goto drop in br_handle_frame().
> > 
> > But, br_handle_ingress_vlan_tunnel() always return 0. So, the
> > routines that check the return value and goto drop has no meaning.
> > 
> > Therefore, change return type of br_handle_ingress_vlan_tunnel() to
> > void and remove if statement of br_handle_frame().
> > 
> > Signed-off-by: Kangmin Park <l4stpr0gr4m@gmail.com>
> 
> Looks good to me,
> Acked-by: Nikolay Aleksandrov <nikolay@nvidia.com>

Applied, thanks!
