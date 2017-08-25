Return-Path: <santosh.shilimkar@oracle.com>
References: <1503670907-23221-1-git-send-email-bhumirks@gmail.com>
	<1503670907-23221-6-git-send-email-bhumirks@gmail.com>
From: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Message-ID: <b3b84569-90d8-4f02-e79d-f7aacc07271a@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1503670907-23221-6-git-send-email-bhumirks@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 5/7] RDS: make rhashtable_params const
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Fri, 25 Aug 2017 15:33:27 -0000
To: Bhumika Goyal <bhumirks@gmail.com>, julia.lawall@lip6.fr, marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com, davem@davemloft.net, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, stephen@networkplumber.org, alex.aring@gmail.com, stefan@osg.samsung.com, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, trond.myklebust@primarydata.com, anna.schumaker@netapp.com, bfields@fieldses.org, jlayton@poochiereds.net, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, bridge@lists.linux-foundation.org, linux-wpan@vger.kernel.org, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, linux-nfs@vger.kernel.org

8/25/2017 7:21 AM, Bhumika Goyal wrote:
> Make this const as it is either used during a copy operation or passed
> to a const argument of the function rhltable_init
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
