From: =?iso-8859-1?q?Fl=E1vio_Pires?= <flavio.defreitas@gmail.com>
Subject: Re: [Bridge] Packet per Second
Date: Fri, 14 Dec 2007 17:30:27 +0000 (UTC)
Message-ID: <nemoFri121407030300@flis.man.torun.pl>
References: <nemoFri121407105527@flis.man.torun.pl>
	<20071214085602.11a09070@deepthought>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: news <news@ger.gmane.org>
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org
Cc: netdev@vger.kernel.org

In article <20071214085602.11a09070@deepthought> Stephen
Hemminger<shemminger@linux-foundation.org> wrote:
>  On Fri, 14 Dec 2007 15:34:10 +0000 (UTC)
>  Fl=87vio Pires <flavio.defreitas@gmail.com> wrote:
>>   Hi all,=20
>>  =20
>>   It's my first time using usenet...
>>  =20
>>   Well, I work on an ISP and we have a linux box acting as a
>> bridge+firewall. With this bridge+firewall we control the packet
>> rate per second from each client and from our repeaters. But I can`t
>> measure the packet rate per IP. Is there any tool for this?
>>  =20
>>   Actually, what I want is to measure the packet rate per IP and
>> generate graphics with mrtg or rrdtool, but for this I must have the
>> number of packets per second of each client :)
>>  =20
>>   Thank you all
>>   --
>>   Fl=87vio
>>  =20
=20

>  Not that I know of, but you might look at:
>  http://www.bandwidtharbitrator.com/

Yeah, we have a proprietary solution from etinc it does bandwidth
control and firewall... but using his firewall let this machine too
slow, so we created a box just for firewall... Then we need a way to
measure pps per host so we can determine which limits fits better to
our clients and our own needs.



--=20

I'm trying a new usenet client for Mac, Nemo OS X.
You can download it at http://www.malcom-mac.com/nemo


