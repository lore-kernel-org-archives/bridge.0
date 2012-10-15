Return-Path: <giometti@enneenne.com>
Date: Mon, 15 Oct 2012 17:24:49 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20121015152449.GF28101@enneenne.com>
References: <20121009142337.GO28136@enneenne.com>
	<201210091842.36717.vitas@nppfactor.kiev.ua>
	<20121009155800.GR28136@enneenne.com>
	<20121012093659.GB14293@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121012093659.GB14293@enneenne.com>
Subject: Re: [Bridge] MSTPd in RSTP mode is sometimes slow...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Cc: bridge@lists.linux-foundation.org

On Fri, Oct 12, 2012 at 11:37:00AM +0200, Rodolfo Giometti wrote:

Looking better my tests here:

> 1038910509.489145: PISM_to_CURRENT: br0:mrvl4:0 
> 1038910510.479677: MSTP_OUT_tx_bpdu: br0:mrvl4 sending RST BPDU

I noticed that we need ~1s from PISM_to_CURRENT to send out the BPDU!

How is it possible? =:-o

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
