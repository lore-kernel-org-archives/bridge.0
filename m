Return-Path: <stephen@networkplumber.org>
Date: Thu, 30 Oct 2014 10:17:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20141030101708.12113903@urahara>
In-Reply-To: <20141029.153745.182320154112584088.davem@davemloft.net>
References: <CA+r1ZhjGo_pWi5hsxra65fCm0kwLfit4ai4_sAiwKKj0fPLxVg@mail.gmail.com>
	<20141029.153745.182320154112584088.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] randconfig build error with next-20141028,
	in net/bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: sfr@canb.auug.org.au, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kyeyoonp@codeaurora.org, linux-next@vger.kernel.org, jim.epost@gmail.com

On Wed, 29 Oct 2014 15:37:45 -0400 (EDT)
David Miller <davem@davemloft.net> wrote:

> From: Jim Davis <jim.epost@gmail.com>
> Date: Tue, 28 Oct 2014 07:52:47 -0700
> 
> > Building with the attached random configuration file,
> > 
> > net/built-in.o: In function `br_handle_frame_finish':
> > (.text+0x40edf): undefined reference to `arp_tbl'
> > net/built-in.o: In function `br_handle_frame_finish':
> > (.text+0x40f3a): undefined reference to `arp_send'
> > make: *** [vmlinux] Error 1
> 
> Kyeyoon-ssi, you will need to do something about this.
> 
> Your choices are either selecting INET (and thus also
> CRYPTO and CRYPTO_AES, since INET needs those in order
> to build properly), making bridging depeng on INET,
> or protecting the new proxy-arp code with INET ifdef
> checks.

Maybe make ARP proxy a config option under bridge and have
it depend on INET?
