Return-Path: <stephen@networkplumber.org>
Date: Tue, 19 May 2015 09:08:36 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20150519090836.35dc2ee2@urahara>
In-Reply-To: <BLUPR03MB13643A6C0CE8F49B31B5E67A91C30@BLUPR03MB1364.namprd03.prod.outlook.com>
References: <BLUPR03MB13643A6C0CE8F49B31B5E67A91C30@BLUPR03MB1364.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] Linux kernel not supporting STP enablement in NON-ROOT
 namespace
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Pullabhatla Vinod <pvinod.sarma@freescale.com>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

On Tue, 19 May 2015 11:14:01 +0000
Pullabhatla Vinod <pvinod.sarma@freescale.com> wrote:

> Hi ,
> Linux doesn't support multiple namspaces while using STP in bridges . What is the actual reason behind supporting only root namespaces for STP support and dropping the BPDU packets for other namespaces. Will there be any issue if I patch the kernel to enable multiple namespace support?
> Please hepl me out.
> 
> Thanks,
> Vinod.
> 
> 
> Thanks,
> Vinod.
> 

I don't think anybody ever made STP namespace aware.
