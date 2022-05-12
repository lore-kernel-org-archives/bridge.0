Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652374065;
 bh=lNnph2yAG9EuWp4xn4hkmL7beGBLq1ZnZACZsxjp9KM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Nbj40Iz88D0V+BmUzUcGlmi2umj/JPseAGp8ve9p9adbnxhMIw5o5HKqqoIgzjAlC
 DeUV2ehaeFQOlKrd7fd7Y924wISPgj2/8F5tR6bUc4uWovrrSf9hBp82erK2Jc4pc3
 A4dvpcTJPE43CwXIJjA1f53t9Qmg/baB3Xz3eECBLToqkBjUwQtS+/U8lrFmzS9ZJF
 xFo9qPHnCW8oDT4cJt7i1K/uVJr3VfpJM1NVURE1DALzcdaqRWCOMKFmXZ2JhDLCCA
 jGdWnL/FQw+dFHr7np3Ga08IwoHGfZt8RyzjJwGfQHb8dVidzC4m5NOHQJ45+fOx4b
 IhinxXtkEOXFQ==
Date: Thu, 12 May 2022 09:47:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220512094743.79f36d81@kernel.org>
In-Reply-To: <c5ec2677-3047-8a70-9769-d48a79703220@nvidia.com>
References: <cover.1652348961.git.eng.alaamohamedsoliman.am@gmail.com>
 <c6069fb695b25dc2f33e8017023ddd47c58caa8d.1652348962.git.eng.alaamohamedsoliman.am@gmail.com>
 <c5ec2677-3047-8a70-9769-d48a79703220@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v7 2/2] net: vxlan: Add extack support
 to vxlan_fdb_delete
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Roopa Prabhu <roopa@nvidia.com>
Cc: shshaikh@marvell.com, jdenham@redhat.com, GR-Linux-NIC-Dev@marvell.com, manishc@marvell.com, alexandre.belloni@bootlin.com, outreachy@lists.linux.dev, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, jesse.brandeburg@intel.com, linux-kernel@vger.kernel.org, vladimir.oltean@nxp.com, sbrivio@redhat.com, claudiu.manoil@nxp.com, anthony.l.nguyen@intel.com, Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>, intel-wired-lan@lists.osuosl.org, pabeni@redhat.com, davem@davemloft.net, UNGLinuxDriver@microchip.com

On Thu, 12 May 2022 09:22:17 -0700 Roopa Prabhu wrote:
> On 5/12/22 02:55, Alaa Mohamed wrote:
> > This patch adds extack msg support to vxlan_fdb_delete and vxlan_fdb_parse.
> > extack is used to propagate meaningful error msgs to the user of vxlan
> > fdb netlink api
> >
> > Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>

Also the patches don't apply to net-next, again.
