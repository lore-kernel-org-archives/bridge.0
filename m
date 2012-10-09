Return-Path: <giometti@enneenne.com>
Date: Tue, 9 Oct 2012 17:47:42 +0200
From: Rodolfo Giometti <giometti@enneenne.com>
Sender: giometti@enneenne.com
Message-ID: <20121009154742.GQ28136@enneenne.com>
References: <20121009142337.GO28136@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20121009142337.GO28136@enneenne.com>
Subject: Re: [Bridge] MSTPd in RSTP mode is sometimes slow...
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Tue, Oct 09, 2012 at 04:23:37PM +0200, Rodolfo Giometti wrote:
> Hello,
> 
> I'm currently using the MSTPd daemon on a custom PowerPC based board
> and I notice that when forced in RSTP mode a port trnasition to the
> forwarding state, sometimes, needs about 1.2s and, sometimes, needs
> about 80ms!

Just to be more complete as possible here a packets dump.

At 17.449146 the ingress BPDU:

0000   01 80 c2 00 00 00 00 0a dc 5a f6 8d 00 27 42 42  .........Z...'BB
0010   03 00 00 02 02 0e 80 00 00 0a dc 5a f6 80 00 00  ...........Z....
0020   00 00 80 00 00 0a dc 5a f6 80 80 0d 00 00 14 00  .......Z........
0030   02 00 10 00 00 31 30 30 4e 43 2d 52              .....100NC-R

At 18.814988 my machine's answer:

0000   01 80 c2 00 00 00 00 02 3e 99 f5 01 00 27 42 42  ........>....'BB
0010   03 00 00 02 02 0e 50 00 00 0a dc 5a e5 20 00 03  ......P....Z. ..
0020   0d 40 80 00 00 02 3e 99 f5 01 80 01 01 00 14 00  .@....>.........
0030   02 00 10 00 00 00 00 00 00 00 00 00              ............

At 18.818471 another ingress BPDU:

0000   01 80 c2 00 00 00 00 0a dc 5a f6 8d 00 27 42 42  .........Z...'BB
0010   03 00 00 02 02 78 50 00 00 0a dc 5a e5 20 00 03  .....xP....Z. ..
0020   0d 53 80 00 00 0a dc 5a f6 80 80 0d 01 00 14 00  .S.....Z........
0030   02 00 10 00 00 31 30 30 4e 43 2d 52              .....100NC-R

And at 19.183731 my machine's answer:

0000   01 80 c2 00 00 00 00 02 3e 99 f5 01 00 27 42 42  ........>....'BB
0010   03 00 00 02 02 3d 50 00 00 0a dc 5a e5 20 00 03  .....=P....Z. ..
0020   0d 40 80 00 00 02 3e 99 f5 01 80 01 01 00 14 00  .@....>.........
0030   02 00 10 00 00 00 00 00 00 00 00 00              ............

Ciao,

Rodolfo

-- 

GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
Freelance ICT Italia - Consulente ICT Italia - www.consulenti-ict.it
