Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650901711;
 bh=/t9m4/CeRlKdtuZXaz3TIf1SxEIJdA7erFumgZsS0uw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=eOh7UZUkEZo/3ZbQ3PFG7Sonks6El6PeCIN27QpESDKgQAErhvEaXm5KHbAphkzpI
 DbS3z0A806wbIW0q73FkzHUMYhjAKBeCDh22sXJeY2YzhqKHBIkrAOTHC9v2TOudcQ
 cnwD6Y+fV1mnE5tfBuHuBckGxp0n4CdDkY99FAwiw/YJLCMLdSsUKXPVdUb6YxF/MJ
 WtdvWJVvQhKG92F8KUwLIgbkDI6QRXTjwKXys/e3UTkxJ6wwqrn8LRrY7HQmI3at9V
 N4YKmmmQD26s3s3ouZxl4FixIONGLzDT6vjUa0tao1QuHX5QadQY8M9RZKdf+Qr63O
 8rWNcE/MfKKyQ==
Date: Mon, 25 Apr 2022 08:48:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220425084829.4b446748@kernel.org>
In-Reply-To: <cover.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
References: <cover.1650896000.git.eng.alaamohamedsoliman.am@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 0/2] propagate extack to
	vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, roopa@nvidia.com, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com

On Mon, 25 Apr 2022 16:25:05 +0200 Alaa Mohamed wrote:
> In order to propagate extack to vxlan_fdb_delete and vxlan_fdb_parse,
> add extack to .ndo_fdb_del and edit all fdb del handelers

Your patches do not apply cleanly to net-next/master. Please rebase and
repost. Please wait 24h between postings to allow additional feedback
to come in.
