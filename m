Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Mon, 18 Jun 2012 14:48:33 +0300
References: <1339763139.49767.YahooMailClassic@web121306.mail.ne1.yahoo.com>
In-Reply-To: <1339763139.49767.YahooMailClassic@web121306.mail.ne1.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201206181448.33159.vitas@nppfactor.kiev.ua>
Subject: Re: [Bridge] Query on Sapnning tree implementation from standard
	point of view
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@lists.linux-foundation.org

On Friday 15 June 2012 15:25:39 Sujata Verma wrote:
> Thanks. I was doing the same experiment on few switches, i could get hold
> of and this is the result:
>
> Cisco Switch catalyst 2950 : Completely ignoring the packet, so validations
> are proper.

Hello, Sujata!
Would the result of the experiment differ if you set Message Age and Max Age 
to the correct values while leaving Hello Time and Forward Delay incorrect:
Message Age = 19 (encoded as 0x13 0x00)
Max Age = 20 (encoded as 0x14 0x00)
Hello Time = 255 (encoded as 0xFF 0x00)
Forward Delay = 255 (encoded as 0xFF 0x00)

How would Cisco switch handle such BPDUs?

-- 
With Best Regards,
Vitalii Demianets
