Return-Path: <davem@davemloft.net>
Date: Wed, 29 Oct 2014 15:37:45 -0400 (EDT)
Message-Id: <20141029.153745.182320154112584088.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <CA+r1ZhjGo_pWi5hsxra65fCm0kwLfit4ai4_sAiwKKj0fPLxVg@mail.gmail.com>
References: <CA+r1ZhjGo_pWi5hsxra65fCm0kwLfit4ai4_sAiwKKj0fPLxVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
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
To: jim.epost@gmail.com
Cc: sfr@canb.auug.org.au, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, stephen@networkplumber.org, kyeyoonp@codeaurora.org, linux-next@vger.kernel.org

From: Jim Davis <jim.epost@gmail.com>
Date: Tue, 28 Oct 2014 07:52:47 -0700

> Building with the attached random configuration file,
> 
> net/built-in.o: In function `br_handle_frame_finish':
> (.text+0x40edf): undefined reference to `arp_tbl'
> net/built-in.o: In function `br_handle_frame_finish':
> (.text+0x40f3a): undefined reference to `arp_send'
> make: *** [vmlinux] Error 1

Kyeyoon-ssi, you will need to do something about this.

Your choices are either selecting INET (and thus also
CRYPTO and CRYPTO_AES, since INET needs those in order
to build properly), making bridging depeng on INET,
or protecting the new proxy-arp code with INET ifdef
checks.
