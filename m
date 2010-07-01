Message-ID: <4C2CDD7B.6080302@navigue.com>
Date: Thu, 01 Jul 2010 14:24:59 -0400
From: Jonathan Thibault <jonathan@navigue.com>
MIME-Version: 1.0
References: <0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5@EXCHANGE.mimos.local>
In-Reply-To: <0E3F7C3131123E42A5B2483A431CAC4202BA05726CD5@EXCHANGE.mimos.local>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Enquiry on Linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ng Ming Ann <ming.ng@mimos.my>
Cc: "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>

 As far as I can tell, the setup you describe should work as expected. I am=
 not sure what causes the problem you describe. The first thing I would che=
ck is if the bridge interfaces (br0) have the same MAC address, they should=
 not.

Jonathan

On 30/06/10 02:37 AM, Ng Ming Ann wrote:
>
> Dear all,
>
> I=92m currently working on a Ethernet bridge for a system. I have a machi=
ne(not PC, but an embedded system) which has two Ethernet ports, I wanted t=
o configure it into a Ethernet bridge which connect other PC.
>
> I have tested on configuring it into a bridge where the two PC able to pi=
ng each other and send files. I=92m wondering that whether I can involve th=
e embedded Linux system in the network, where the two PC able to detect the=
 Linux OS( embedded system) and able to send files and communicate with it =
as the figure below:
>
> Rounded Rectangle: Embedded System ( Bridge)
>
>
> =09
> =09
> =09
> =09
> =09
> =09
> =09
>
> =09
>
> PC1
>
> =09
> =09
>
> PC2
>
>
>
> =09
> =09
>
> PC1
>
> =09
> =09
>
> PC2
>
>
> I have try to add an IP to the bridge (virtual port) and the PCs are able=
 to Ping the bridge=92s IP.
>
> Then I=92d tried to configure the network to be like below:
>
> Rounded Rectangle: Embedded System ( Bridge2)Rounded Rectangle: Embedded =
System ( Bridge1)
>
> PC1 and PC2 can ping each other can communicate well. I have added IP to =
both bridge, but the result is that, PC1 only able to ping bridge1=92s IP a=
nd not bridge2=92s IP. PC2 as well, is only able to ping bridge2=92s IP and=
 not able to ping bridge1=92s IP.
>
> Do you have any suggestion for me to configure the bridge so that both br=
idge can be detected by each of the PC that connected to them?
>
> Thank you very much in advance.
>
> Regards,
>
> Ming Ann
>
>
> ------------------------------------------------------------------
> -
> -
> DISCLAIMER:
>
> This e-mail (including any attachments) is for the addressee(s)
> only and may contain confidential information. If you are not the
> intended recipient, please note that any dealing, review,
> distribution, printing, copying or use of this e-mail is strictly
> prohibited. If you have received this email in error, please notify
> the sender immediately and delete the original message.
> MIMOS Berhad is a research and development institution under
> the purview of the Malaysian Ministry of Science, Technology and
> Innovation. Opinions, conclusions and other information in this e-
> mail that do not relate to the official business of MIMOS Berhad
> and/or its subsidiaries shall be understood as neither given nor
> endorsed by MIMOS Berhad and/or its subsidiaries and neither
> MIMOS Berhad nor its subsidiaries accepts responsibility for the
> same. All liability arising from or in connection with computer
> viruses and/or corrupted e-mails is excluded to the fullest extent
> permitted by law.
>
>
>
> _______________________________________________
> Bridge mailing list
> Bridge@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/bridge

