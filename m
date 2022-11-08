Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A64928129E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABC2580DB9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=77MlvYrSo2GNKJVGomS31FpqZbhx0yNZ6IAPQdhRuvE=;
 b=eKNRxNVDQhX53Qn4SGuahJRXIOuG1FJ4gw6S+uoiOkDIjuhaWTQjcr3tKyOOz618lR
 x0HefKtXnQFMyyfCTLapRDkzUJE4Kpe3s9zllRYhl6o+7tEvByAcqr7II6MI8C8kqOee
 +R2oo6jwxNw+NIwSOV0/sBRk1WePr8XU5rd4LTfzH/ijqOrWdTDFkxDNCPUBBSaPwGld
 8MrfhrDIymXCcVtH8I1Qdw5MBJuqSFI+latc0n7Y2mNlfVU070SkjKBX/GrKV+Q89moG
 fuQ8JXxzeP4YjIGAFg1U4ntsDIDgurxLxnw02zTe/wBOLnsEr7rPmTEYYMSVSveoKMSS
 YVog==
Date: Tue, 8 Nov 2022 17:31:11 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221108153111.vlyb2lxo7rm2i3kk@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com> <Y2o2dB+k+yDHRVtA@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2o2dB+k+yDHRVtA@shredder>
Subject: Re: [Bridge] [PATCH net-next 00/15] mlxsw: Add 802.1X and MAB
	offload support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>, Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, vladimir.oltean@nxp.com, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>, Eric Dumazet <edumazet@google.com>, mlxsw@nvidia.com, Jiri Pirko <jiri@nvidia.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Nov 08, 2022 at 12:59:00PM +0200, Ido Schimmel wrote:
> + Vladimir
> 
> You weren't copied on the patches by mistake. They are available here:
> https://lore.kernel.org/netdev/cover.1667902754.git.petrm@nvidia.com/

Thanks for copying me. The patches look great to my eyes. I didn't go
into details into the mlxsw details, just because I really have no clue
there.
