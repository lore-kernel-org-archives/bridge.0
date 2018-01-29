Return-Path: <adrian27oradea@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=tZKwfcOYcsrRvOHfm7Dxnrb2Dvr7tQ7sCUElqM6YR24=;
	b=spcQKnM1bZfTv+FQvbnY9eMsz18krnNYIQFuSnpMlthVfA1N6Vs38yqM7KqkmTSvqE
	p9Qo1C/B01ldO33w65FzJgr9MNbEwi1iu+74ijyyhTjkDJVLoI0m1KEJ2fz/PYUUeNjU
	hBHklfIAYkWNdUzxk1jJA2OIaPV8YYPsk6OX1OaqCtayyG7NdTI1w+IGU7Hv7DTXJlK4
	Wn9Wmo+ENt2EUDTSQxF/L+qK+d2Ek97m03qu5DVJ8XFlAQyHaHJzgh5vGLf3RMCYvEsQ
	rDtXpzegWfw7W9BGV8Ie7ppq52H/+2wKx0uWs3ArOvmD9N2LdFTGfhlGwtPU1Rj/jv3y
	upaQ==
MIME-Version: 1.0
In-Reply-To: <20180128142826.15c9fcbf@xeon-e3>
References: <CA+k9h3O2OFKjoPqhN4LBnMODX=M607nwGfLiaAm+BB4T4mmEDw@mail.gmail.com>
	<20180128142826.15c9fcbf@xeon-e3>
From: Adrian Pascalau <adrian27oradea@gmail.com>
Date: Mon, 29 Jan 2018 09:51:35 +0200
Message-ID: <CA+k9h3PnKU0cvuyrd6BgYQEVHAnSm9gRDw-o2Vpc11evFGhoSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] ssh connection not working when ssh server is behind a
 linux bridge
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: bridge@lists.linux-foundation.org

On Mon, Jan 29, 2018 at 12:28 AM, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> These symptoms sound like an MTU mismatch.
> The padding is not related. More likely, the issue is that one side
> is sending a larger frame than the MTU of the underlying interface.
> Since the bridge is a pure layer 2 interface, it has not choice
> but to drop any frame where the size is greater than the MTU.

I did some traces in both ssh client and server side, and I can find
all the frames in both sides, no one is missing.

Here is an example with the padding issue I see: in the ssh server
side, there is a 54 bytes TCP ACK frame send by the server, to
acknowledge that it has received the initial ssh client protocol
version advertisement:

x.x.x.250    x.x.x.115    SSHv2    82    Client: Protocol
(SSH-2.0-PuTTY_Release_0.70)
x.x.x.115    x.x.x.250    TCP        54    22 =E2=86=92 49810 [ACK] Seq=3D1
Ack=3D29 Win=3D29312 Len=3D0

In this 54 bytes TCP ACK frame, the Ethernet II header is 14 bytes
long, the IP header is 20 bytes long, the TCP header is another 20
bytes in length, and there is no TCP payload, so in total 54 bytes.
When this frame arrives in the client side, it is 60 bytes in length,
and it is interpreted by the Wireshark as a SSHv2 frame, because of
the 6 additional 0x00 padding bytes in the TCP payload. I find this
exact frame in a working ssh session, and those 6 additional 0x00
padding bytes are correctly shows at the Ethernet II frame level.

x.x.x.250    x.x.x.115    SSHv2    82    Client: Protocol
(SSH-2.0-PuTTY_Release_0.70)
x.x.x.115    x.x.x.250    SSHv2    60    Server: Encrypted packet (len=3D6)

Frame 5: 60 bytes on wire (480 bits), 60 bytes captured (480 bits) on
interface 0
Ethernet II, Src: RealtekU_40:31:85 (52:54:00:40:31:85), Dst:
Vmware_a6:ba:8a (00:50:56:a6:ba:8a)
    Destination: Vmware_a6:ba:8a (00:50:56:a6:ba:8a)
    Source: RealtekU_40:31:85 (52:54:00:40:31:85)
    Type: IPv4 (0x0800)
Internet Protocol Version 4, Src: x.x.x.115, Dst: x.x.x.250
    0100 .... =3D Version: 4
    .... 0101 =3D Header Length: 20 bytes (5)
    Differentiated Services Field: 0x00 (DSCP: CS0, ECN: Not-ECT)
    Total Length: 46
    Identification: 0xf6f1 (63217)
    Flags: 0x02 (Don't Fragment)
    Fragment offset: 0
    Time to live: 64
    Protocol: TCP (6)
    Header checksum: 0x76d4 [validation disabled]
    [Header checksum status: Unverified]
    Source: x.x.x.115
    Destination: x.x.x.250
    [Source GeoIP: Unknown]
    [Destination GeoIP: Unknown]
Transmission Control Protocol, Src Port: 22, Dst Port: 49810, Seq: 1,
Ack: 29, Len: 6
    Source Port: 22
    Destination Port: 49810
    [Stream index: 0]
    [TCP Segment Len: 6]
    Sequence number: 1    (relative sequence number)
    [Next sequence number: 7    (relative sequence number)]
    Acknowledgment number: 29    (relative ack number)
    0101 .... =3D Header Length: 20 bytes (5)
    Flags: 0x010 (ACK)
    Window size value: 229
    [Calculated window size: 29312]
    [Window size scaling factor: 128]
    Checksum: 0x9e76 [correct]
    [Checksum Status: Good]
    [Calculated Checksum: 0x9e76]
    Urgent pointer: 0
    [SEQ/ACK analysis]
    TCP payload (6 bytes)
SSH Protocol
    SSH Version 2
        Packet Length (encrypted): 00000000
        Encrypted Packet: 0000
