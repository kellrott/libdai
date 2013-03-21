/*  This file is part of libDAI - http://www.libdai.org/
 *
 *  Copyright (c) 2006-2011, The libDAI authors. All rights reserved.
 *
 *  Use of this source code is governed by a BSD-style license that can be found in the LICENSE file.
 */


%module dai

%include "std_string.i"
%include "std_vector.i"
%include "std_map.i"
%template(IntVector) std::vector<size_t>;
//%include "std_set.i"  /* for python */

%{
#define DAI_WITH_BP 1
#define DAI_WITH_FBP 1
#define DAI_WITH_TRWBP 1
#define DAI_WITH_MF 1
#define DAI_WITH_HAK 1
#define DAI_WITH_LC 1
#define DAI_WITH_TREEEP 1
#define DAI_WITH_JTREE 1
#define DAI_WITH_MR 1
#define DAI_WITH_GIBBS 1
#define DAI_WITH_CBP 1
#define DAI_WITH_DECMAP 1
#define DAI_WITH_GLC 1
#include "../include/dai/alldai.h"

using namespace dai;
%}

// ************************************************************************************************
%include "../include/dai/util.h"

// ************************************************************************************************
%ignore dai::Var::label() const;
%ignore dai::Var::states() const;
%ignore operator<<(std::ostream&, const Var&);
%include "../include/dai/var.h"
%extend dai::Var {
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
};

// ************************************************************************************************
%ignore operator<<(std::ostream&, const SmallSet&);
%rename(__eq__) operator==(const SmallSet&, const SmallSet&); /* for python */
%rename(__ne__) operator!=(const SmallSet&, const SmallSet&); /* for python */
%rename(__lt__) operator<(const SmallSet&, const SmallSet&);  /* for python */
%include "../include/dai/smallset.h"
%template(SmallSetVar) dai::SmallSet< dai::Var >;
%extend dai::SmallSet<dai::Var> {
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
}

// ************************************************************************************************
%ignore operator<<(std::ostream&, const VarSet&);
%include "../include/dai/varset.h"
%extend dai::VarSet {
    inline void append(const dai::Var &v) { (*self) |= v; }   /* for python, octave */
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
};

// ************************************************************************************************
%ignore dai::TProb::operator[];
%include "../include/dai/prob.h"
%template(Prob) dai::TProb<dai::Real>;
%extend dai::TProb<dai::Real> {
    inline dai::Real __getitem__(int i) const {return (*self).get(i);} /* for python */
    inline void __setitem__(int i,dai::Real d) {(*self).set(i,d);}   /* for python */
    inline dai::Real __paren(int i) const {return (*self).get(i);}     /* for octave */
    inline void __paren_asgn(int i,dai::Real d) {(*self).set(i,d);}  /* for octave */
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
};

// ************************************************************************************************
%ignore dai::TFactor::operator[];
%include "../include/dai/factor.h"
%extend dai::TFactor<dai::Real> {
    inline dai::Real __getitem__(int i) const {return (*self).get(i);} /* for python */
    inline void __setitem__(int i,dai::Real d) {(*self).set(i,d);}   /* for python */
    inline dai::Real __paren__(int i) const {return (*self).get(i);}     /* for octave */
    inline void __paren_asgn__(int i,dai::Real d) {(*self).set(i,d);}  /* for octave */
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
};
%template(Factor) dai::TFactor<dai::Real>;
%inline %{
typedef std::vector<dai::Factor> VecFactor;
typedef std::vector<VecFactor> VecVecFactor;
%}
%template(VecFactor) std::vector<dai::Factor>;
%template(VecVecFactor) std::vector<VecFactor>;

// ************************************************************************************************
%ignore operator<<(std::ostream&, const GraphAL&);
%rename(toInt) dai::Neighbor::operator size_t() const;
%include "../include/dai/graph.h"
%extend dai::GraphAL {
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
}

// ************************************************************************************************
%ignore operator<<(std::ostream&, const BipartiteGraph&);
%include "../include/dai/bipgraph.h"
%extend dai::BipartiteGraph {
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
}

// ************************************************************************************************
%ignore operator<<(std::ostream&, const FactorGraph&);
%ignore operator>>(std::istream&,FactorGraph&);
%include "../include/dai/factorgraph.h"
%extend dai::FactorGraph {
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
}

// ************************************************************************************************
%ignore operator<<(std::ostream&, const RegionGraph&);
%include "../include/dai/regiongraph.h"
%extend dai::RegionGraph {
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
}

// ************************************************************************************************
//%ignore operator<<(std::ostream&, const CobwebGraph&);
//%include "../include/dai/cobwebgraph.h"
//%extend dai::CobwebGraph {
//    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
//    inline std::string __str() const { return (*self).toString(); }  /* for octave */
//}
//TODO fix problems with CobwebGraph

// ************************************************************************************************
%ignore operator<<(std::ostream&, const PropertySet&);
%ignore operator>>(std::istream&,PropertySet&);
%include "../include/dai/properties.h"
%extend dai::PropertySet {
    inline void __setitem__(char *name, char *val) {
        self->set(std::string(name), std::string(val));
    }
    inline const char* __str__() const { return (*self).toString().c_str(); }  /* for python */
    inline std::string __str() const { return (*self).toString(); }  /* for octave */
}

// ************************************************************************************************
%ignore dai::IndexFor::operator++;
%rename(toInt) dai::IndexFor::operator size_t() const;
%ignore dai::Permute::operator[];
%ignore dai::multifor::operator++;
%ignore dai::multifor::operator[];
%rename(toInt) dai::multifor::operator size_t() const;
%ignore dai::State::operator++;
%rename(toInt) dai::State::operator size_t() const;
%ignore dai::State::operator const std::map<Var,size_t>&;
%include "../include/dai/index.h"
%extend dai::IndexFor {
    inline void next() { return (*self)++; }
};
%extend dai::Permute {
    inline size_t __getitem__(int i) const {return (*self)[i];} /* for python */
    inline size_t __paren__(int i) const {return (*self)[i];}   /* for octave */
};
%extend dai::multifor {
    inline void next() { return (*self)++; }
    inline size_t __getitem__(int i) const {return (*self)[i];} /* for python */
    inline size_t __paren__(int i) const {return (*self)[i];}   /* for octave */
};
%extend dai::State {
    inline void next() { return (*self)++; }
};

// ************************************************************************************************
%include "../include/dai/daialg.h"
//TODO: why do the following lines not work?
%template(DAIAlgFG) dai::DAIAlg<dai::FactorGraph>;
%template(DAIAlgRG) dai::DAIAlg<dai::RegionGraph>;
%template(DAIAlgCG) dai::DAIAlg<dai::CobwebGraph>;

// ************************************************************************************************
%include "../include/dai/alldai.h"

// ************************************************************************************************
%ignore dai::BP::operator=;
%feature("notabstract") dai::BP; //SWIG mis-identifies the InfAlg classes as being virtual...
%include "../include/dai/bp.h"

// ************************************************************************************************
%feature("notabstract") dai::FBP;
%include "../include/dai/fbp.h"

// ************************************************************************************************
%feature("notabstract") dai::TRWBP;
%include "../include/dai/trwbp.h"

// ************************************************************************************************
%feature("notabstract") dai::MF;
%include "../include/dai/mf.h"

// ************************************************************************************************
%feature("notabstract") dai::HAK;
%include "../include/dai/hak.h"

// ************************************************************************************************
%feature("notabstract") dai::LC;
%include "../include/dai/lc.h"

// ************************************************************************************************
%feature("notabstract") dai::JTree;
%include "../include/dai/jtree.h"

// ************************************************************************************************
%ignore dai::TreeEP::operator=;
%feature("notabstract") dai::TreeEP;
%include "../include/dai/treeep.h"

// ************************************************************************************************
%feature("notabstract") dai::MR;
%include "../include/dai/mr.h"

// ************************************************************************************************
%feature("notabstract") dai::Gibbs;
%include "../include/dai/gibbs.h"

// ************************************************************************************************
%feature("notabstract") dai::CBP;
%include "../include/dai/cbp.h"

// ************************************************************************************************
%feature("notabstract") dai::DecMAP;
%include "../include/dai/decmap.h"

// ************************************************************************************************
%include "../include/dai/glc.h"

// ************************************************************************************************
%include "../include/dai/evidence.h"
%include "../include/dai/emalg.h"

%inline %{
typedef std::map<dai::Var, size_t> Observation;
typedef std::vector<Observation> ObservationVec;

typedef std::vector<dai::Var> VecVar;
typedef std::map<size_t, VecVar > FactorOrientations;

typedef std::vector<dai::SharedParameters> VecSharedParameters;

typedef std::vector<dai::MaximizationStep> VecMaximizationStep;

%}
%template(Observation) std::map<dai::Var, size_t>;
%template(ObservationVec) std::vector<Observation>;
%template(VecVar) std::vector<dai::Var>;
%template(FactorOrientations) std::map<size_t,VecVar>; 
%template(VecSharedParameters) std::vector<dai::SharedParameters >;
%template(VecMaximizationStep) std::vector<dai::MaximizationStep >;
