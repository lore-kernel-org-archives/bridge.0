Return-Path: <shemminger@vyatta.com>
Date: Tue, 6 Mar 2012 09:09:05 -0800
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20120306090905.0bc1a527@nehalam.linuxnetplumber.net>
In-Reply-To: <4F56208E.2090801@gmail.com>
References: <20120306142219.31783.30201.stgit@localhost.localdomain>
	<4F56208E.2090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] bridge: fix "entering disabled state" logging
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

On Tue, 06 Mar 2012 16:34:54 +0200
Paulius Zaleckas <paulius.zaleckas@gmail.com> wrote:

> On 03/06/2012 04:22 PM, Paulius Zaleckas wrote:
> > Now we have:
> > eth0: link down
> > br0: port 1(eth0) entering forwarding state
> >
> > State should be logged *after* it was changed, not before.
> 
> The funny thing is that it was introduced:
> 2010-05-16 	stephen hemminger
> bridge: change console message interface
> 28a16c97963d3bc36a2c192859f6d8025ef2967a
> 
> and no one noticed since then :D

The message could be corrected to have correct verb tense. s/entering/entered/

Acked-by: Stephen Hemminger <shemminger@vyatta.com>



