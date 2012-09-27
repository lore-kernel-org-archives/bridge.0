Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Thu, 27 Sep 2012 17:04:08 +0300
References: <SNT129-DS1085705FE6740107589E1E92830@phx.gbl>
In-Reply-To: <SNT129-DS1085705FE6740107589E1E92830@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201209271704.08714.vitas@nppfactor.kiev.ua>
Subject: Re: [Bridge] Questions about MSTP support.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Thursday 27 September 2012 16:32:21 v g wrote:
> Hi all.
>
> I need to use STP (ideally MST) on centos 6.3. I've read that it's
> supported in linux kernel as part of IEEE 802.1Q standard,

Kernel has no support for the MSTP. It only implements 802.1d-1998 plain old 
STP.

> but can't find any information on configuring miltiple spanning trees.
> So - help? suggestions? rtfm (as long as you point me to actual manual)?
> anything?
>

Take a look at open-source MSTP user-space demon here: 
http://sourceforge.net/p/mstpd/wiki/Home/
You can use it to get 802.1Q-2005 compatible RSTP/STP support with the 
standard kernel. Although It is still in alpha stage, I have a couple of 
reports about successfull RSTP implementations using it.

As for MST - you need extra MSTP-aware hardware + specialized driver for that 
hardware. Alternatively you could modify the bridge subsystem code in kernel. 
In current state without modifications it has no support for the per-MST port 
states.

-- 
With Best Regards,
Vitalii Demianets
