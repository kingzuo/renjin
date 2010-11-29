/*
 * R : A Computer Language for Statistical Data Analysis
 * Copyright (C) 1995, 1996  Robert Gentleman and Ross Ihaka
 * Copyright (C) 1997--2008  The R Development Core Team
 * Copyright (C) 2003, 2004  The R Foundation
 * Copyright (C) 2010 bedatadriven
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

package r.lang;

/**
 * Marker interface that restricts the type of a parameter or member to
 * either a {@code PairList} (one or more elements) or {@code NullExp} (empty list).
 *
 * This aligns to the primitive function "is.pairlist"
 */
public interface PairList extends Iterable<SEXP> {

  int length();

  <S extends SEXP> S get(int i);
  Iterable<PairListExp> listNodes();

  void accept(SexpVisitor visitor);
  SEXP findByTag(SymbolExp symbol);
}