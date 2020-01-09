Return-Path: <ast@fiberby.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
 s=201905; t=1578591697;
 bh=aO90ZkWcNxvVfMQ699FY54Oi71pyX/FoCIGUYqP1+0U=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=ZGdO3bXag3oQlpfK+0ry+F2q+jK9NIvMoyCTZ+8g9s+A5xN6ZwndRz+s0AzM6Hjri
 vJT0o0qp16Oooy5k36E16sHSREKf2SpYLk9WYAvXLgDD3Td2OBAqG/oGyh6Woxe45k
 irwutle4gtBzSVE4jfjejfDbJxyt1hg9bhjwymFPIh68o9032/zKqmSOQuYI/ly/Zx
 4EWS9aTpVexV78lZonSKKVul6ey7gZofKsCB1Q7ocC89MNvl3Ar2fS/7Wn3OpB2t4D
 aa6nMdpgdh89WFlMINxTgHHCo6ZSVzFTtGr7B2KcwudgJilzAt9zEnqlfE9EZY9aDG
 V5wfaYA+QQ33A==
References: <20200109150640.532-1-horatiu.vultur@microchip.com>
 <20200109081907.06281c0f@hermes.lan>
From: =?UTF-8?Q?Asbj=c3=b8rn_Sloth_T=c3=b8nnesen?= <ast@fiberby.net>
Message-ID: <da02006c-dc9d-ce1a-861e-4fc1c1dc2830@fiberby.net>
Date: Thu, 9 Jan 2020 17:41:33 +0000
MIME-Version: 1.0
In-Reply-To: <20200109081907.06281c0f@hermes.lan>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [RFC net-next Patch 0/3] net: bridge: mrp: Add support
 for Media Redundancy Protocol(MRP)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, jakub.kicinski@netronome.com, davem@davemloft.net, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Jesper Dangaard Brouer <brouer@redhat.com>, anirudh.venkataramanan@intel.com, jiri@mellanox.com, jeffrey.t.kirsher@intel.com, dsahern@gmail.com, olteanv@gmail.com, vivien.didelot@gmail.com

Hi Horatiu and Stephen,

Horatiu, thanks for giving this a try. I am looking forward to maybe someday
be able to run ERPS on white box switches.

On 1/9/20 4:19 PM, Stephen Hemminger wrote:
> Can this be implemented in userspace?
> 
> Putting STP in the kernel was a mistake (even original author says so).
> Adding more control protocols in kernel is a security and stability risk.

Another case is VRRP, ERPS (ITU-T G.8032), VRRP group.

My use-case might not be common, but I have machines with about 10k net_dev (QinQ),
I would like to be able to do VRRP group on the outer VLANs, which are only a few
hundred instances without excessive context switching. I would then keep the the
normal keep-alive state machine in kernel, basically a BPF-based timed periodic
packet emitter facility and a XDP recieve hook. So only setup and event handling
has to context switched to user-space.

Unfortunately I haven't had time to explore this yet, but I think such an approach
could solve a few of the reasons that scalable bridge/ring/ha protocols have to wait
20 years before being implemented in Linux.

-- 
Best regards
Asbjørn Sloth Tønnesen
Network Engineer
Fiberby ApS - AS42541
