Return-Path: <vitas@nppfactor.kiev.ua>
From: Vitalii Demianets <vitas@nppfactor.kiev.ua>
Date: Thu, 1 Mar 2012 13:06:48 +0200
References: <1330454231-23852-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<201203011136.48018.vitas@nppfactor.kiev.ua>
	<OFF937C97D.760DD666-ONC12579B4.003AB9A4-C12579B4.003B6A41@transmode.se>
In-Reply-To: <OFF937C97D.760DD666-ONC12579B4.003AB9A4-C12579B4.003B6A41@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201203011306.48997.vitas@nppfactor.kiev.ua>
Subject: Re: [Bridge] [PATCH 1/2] bridge: Adjust min age inc for HZ > 256
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: bridge@lists.linux-foundation.org

On Thursday 01 March 2012 12:48:58 Joakim Tjernlund wrote:
> > Just a nitpick: I think the following is a little bit more accurate (take
> > into account cases when HZ is multiple of 256, which is rare but
> > possible):
> >
> > -#define MESSAGE_AGE_INCR   ((HZ < 256) ? 1 : (HZ/256))
> > +#define MESSAGE_AGE_INCR   ((HZ / 256) + ((HZ % 256) ? 1 : 0))
>
> hmm, HZ 256 isn't selectable today AFAIK,

Yes, today. Things change :)

> but even if it was adding an 
> extra tick would not cause any malfunction of STP.

Yes, no harm. I just love things to be accurate :)

-- 
Vitalii Demianets
