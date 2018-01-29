Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=6aLG10DqVKuUbe71Lac/p6TBQkJx+bV24qj6qki824o=;
	b=UvkX7wvUbxAiibV34RE5RPJnP/8QzaBf1eM0PiTdnSVal7WNIN9kkGxIpkvToHE2R0
	HmTRFOUvIm8JIMsR4n2mWnZ31C47sWY6fApLtFrh/wtnIbrTWgveKCXSdZ3QkYR0cGQ0
	FSK7zjnPXRy3RVuomMQ/ZaoVP7qaUH+RPfXm5K52yIFhNrcy4zB7LjPIYE1jFRnzlo50
	yrDy+uW/+MakCyGFMgjB4H9iD/n50nKAaaC07Vq3JC6OY2cJgEbbawGuCFzqDB/pnwl2
	TPcSgRpEupbJsFFFQk4MA9/ecisIbgrXQ0B/emP2ARqZD5Vr3Otq9pw3JK7jJNxBPNQy
	bKaw==
Date: Mon, 29 Jan 2018 12:38:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180129123848.64796ce6@xeon-e3>
In-Reply-To: <8ada1d8f-369e-b8b8-48c1-362500e37e8f@man.szczecin.pl>
References: <CA+k9h3O2OFKjoPqhN4LBnMODX=M607nwGfLiaAm+BB4T4mmEDw@mail.gmail.com>
	<20180128142826.15c9fcbf@xeon-e3>
	<8ada1d8f-369e-b8b8-48c1-362500e37e8f@man.szczecin.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Seweryn Niemiec <ser@man.szczecin.pl>
Cc: bridge@lists.linux-foundation.org

On Mon, 29 Jan 2018 10:42:19 +0100
Seweryn Niemiec <ser@man.szczecin.pl> wrote:

> On 28.01.2018 23:28, Stephen Hemminger wrote:
> > These symptoms sound like an MTU mismatch.
> > The padding is not related. More likely, the issue is that one side
> > is sending a larger frame than the MTU of the underlying interface.
> > Since the bridge is a pure layer 2 interface, it has not choice
> > but to drop any frame where the size is greater than the MTU.  
> 
> I have a similar problem (same infrastructure and same symptoms) but with random
> occurrence. Ssh session hangs randomly, usually before the login prompt is
> shown), sometimes a bit later, sometimes after few days. I have MTU 1500 on all
> interfaces taking part in communication. Ping of any size works and as far as I
> tested, HTTP communication too, but there are problems with HTTPS.
> 

If you see that, it usually is some middlebox in the way intefering with packets.
