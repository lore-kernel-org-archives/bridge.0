Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2C7F3416BC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 36123416B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=2gmtNIUUpvopJUec+O7hhUT0Dno5h9V+8LiFQ4qDF9o=;
 b=k4SKpSa3N3YVNVsGETrFqgc7O1Gei21+1Bl7GKznWtW7g/CY4lqGhIVu0U8vhpPzQz
 Plh+/nM/rqhALQbZVIwSq16R4FXRKq1d+Yml3HubQr/QOkC5+adlVohA2mul6H6GMQHj
 sUrwalKo/99FfC/arjGzEpurzBOj5+/Hn2FszJYNlbrIlRKgT8yx6JX+Pgc9326oL/yg
 hq4wRuLrJiCpEsiQZmT0j4QBYzyQdwVveiB3U0qZZjqxie/GPYR4i8O13TTQbJT1GmOM
 UKxBmtPp2nRaBaKeS3tJ1ZOXUrVLNF77EnXNaSZeZbU64bNooizuYgajBY02YU37AQJI
 zxXQ==
Date: Sun, 17 Jul 2022 15:57:18 +0300
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220717125718.mj7b3j3jmltu6gm5@skbuf>
References: <20220708084904.33otb6x256huddps@skbuf>
 <e6f418705e19df370c8d644993aa9a6f@kapio-technology.com>
 <20220708091550.2qcu3tyqkhgiudjg@skbuf>
 <e3ea3c0d72c2417430e601a150c7f0dd@kapio-technology.com>
 <20220708115624.rrjzjtidlhcqczjv@skbuf>
 <723e2995314b41ff323272536ef27341@kapio-technology.com>
 <YsqPWK67U0+Iw2Ru@shredder>
 <d3f674dc6b4f92f2fda3601685c78ced@kapio-technology.com>
 <Ys69DiAwT0Md+6ai@shredder>
 <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <648ba6718813bf76e7b973150b73f028@kapio-technology.com>
Subject: Re: [Bridge] [PATCH v4 net-next 3/6] drivers: net: dsa: add locked
 fdb entry flag to drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>, Eric Dumazet <edumazet@google.com>, linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Sun, Jul 17, 2022 at 02:21:47PM +0200, netdev@kapio-technology.com wrote:
> On 2022-07-13 14:39, Ido Schimmel wrote:
> > On Wed, Jul 13, 2022 at 09:09:58AM +0200, netdev@kapio-technology.com
> > wrote:
> 
> > 
> > What are "Storm Prevention" and "zero-DPV" FDB entries?
> 
> They are both FDB entries that at the HW level drops all packets having a
> specific SA, thus using minimum resources.
> (thus the name "Storm Prevention" aka, protection against DOS attacks. We
> must remember that we operate with CPU based learning.)

DPV means Destination Port Vector, and an ATU entry with a DPV of 0
essentially means a FDB entry pointing nowhere, so it will drop the
packet. That's a slight problem with Hans' implementation, the bridge
thinks that the locked FDB entry belongs to port X, but in reality it
matches on all bridged ports (since it matches by FID). FID allocation
in mv88e6xxx is slightly strange, all VLAN-unaware bridge ports,
belonging to any bridge, share the same FID, so the FDB databases are
not exactly isolated from each other.
